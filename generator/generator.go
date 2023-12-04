package generator

import (
	"database/sql"
	"embed"
	"fmt"
	"os"
	"strings"
	"text/template"

	"github.com/starfork/gostar/generator/sql2pb"
)

//go:embed templates/*
var tplFs embed.FS

var Gtr *Generator

type Generator struct {
	s *sql2pb.Schema

	svcName string
	//model   string
	basePath string

	initProject bool
}

func New(opts ...Option) (*Generator, error) {

	opt := DefaultOptions()
	for _, o := range opts {
		o(&opt)
	}

	connStr := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", opt.dbUser, opt.dbPasswd, opt.dbHost, opt.dbPort, opt.dbName)
	var db *sql.DB
	var err error
	if db, err = sql.Open(opt.dbType, connStr); err != nil {
		return nil, err
	}
	g := &Generator{
		svcName:     opt.svcName,
		basePath:    opt.basePath + opt.svcName + "/",
		initProject: false,
	}

	defer db.Close()
	if g.s, err = sql2pb.GenerateSchema(db, opt.models, opt.svcName, opt.svcName,
		opt.fieldStyle, opt.tablePrefix, nil, nil); err != nil {
		return nil, err
	}
	return g, nil
}

// 项目目录
func (e *Generator) Folders() error {
	dirs := []string{
		"cmd",
		"config",
		"internal",
		"internal/server",
		"internal/consts",
		"internal/codes",
		"internal/logic",
		"internal/repository",
		"internal/repository/mysql",
		"pkg",
		"pkg/proto",
		"pkg/pb",
	}
	os.Mkdir(e.basePath, os.ModePerm)
	for _, v := range dirs {
		os.Mkdir(e.basePath+v, os.ModePerm)
		//目录检测，不成功返回？
	}
	return nil
}

func (e *Generator) SpecificFiles() {
	fileMap := map[string]string{
		"proto.handler.tpl":         "pkg/proto/" + e.svcName + "_handler" + ".proto", //xxx_handler.proto
		"server.handler.tpl":        "internal/server/handler.go",
		"repository.tpl":            "internal/repository/repository.go",
		"makefile.tpl":              "Makefile",
		"main.go.tpl":               "cmd/main.go",
		"debug.json.tpl":            "config/debug.json",
		"server.config.go.tpl":      "internal/server/server_config.go",
		"repository.model.base.tpl": "internal/repository/mysql/base.go",
	}
	for k, v := range fileMap {
		e.genTpl(k, v)
	}
}

// 生成模块
func (e *Generator) Models() error {
	type messsage struct {
		ServiceName string
		Name        string
		Fields      []sql2pb.MessageField
		FielNum     int
	}
	for _, m := range e.s.Messages {
		msg := messsage{
			ServiceName: e.s.ServiceName,
			Name:        m.Name,
			Fields:      m.Fields,
			FielNum:     len(m.Fields),
		}
		fName := strings.ToLower(m.FileName)
		e.genTpl("proto.model.tpl", "pkg/proto/"+e.svcName+"_"+fName+".proto", msg)
		e.genTpl("server.model.tpl", "internal/server/"+fName+".go", msg)
		e.genTpl("repository.model.tpl", "internal/repository/mysql/"+fName+".go", msg)

	}
	return nil
}

func (e *Generator) genTpl(tpl, f string, data ...any) {
	var tf *os.File
	var err error
	var t *template.Template
	var d any
	if len(data) > 0 {
		d = data[0]
	} else {
		d = e.s
	}

	if t, err = e.newTpl(tpl); err != nil {
		panic(err)
	}
	if tf, err = e.createFile(f); err != nil {
		panic(err)
	}
	if err = t.Execute(tf, d); err != nil {
		panic(err)
	}
	defer tf.Close()
}

func (e *Generator) createFile(f string) (*os.File, error) {
	//fmt.Println("create file : " + e.basePath + f)
	return os.Create(e.basePath + f)
}

func (e *Generator) newTpl(name string) (*template.Template, error) {
	return template.New(name).Funcs(template.FuncMap{
		"ucwords": Ucwords,
		"inc":     Inc,
		"topath":  ToPath,
		"lower":   Lower,
	}).ParseFS(tplFs, "templates/"+name)
}
