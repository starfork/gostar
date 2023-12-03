package generator

import (
	"database/sql"
	"fmt"
	"os"
	"strings"
	"text/template"

	"github.com/starfork/gostar/generator/sql2pb"
	"github.com/urfave/cli/v2"
)

type Generator struct {
	s *sql2pb.Schema

	svcName string
	//model   string
	basePath string
	genType  string
}

func NewCtx(ctx *cli.Context) (*Generator, error) {
	return New(
		DbHost(ctx.String("db_host")),
		DbName(ctx.String("db_name")),
		DbPasswd(ctx.String("db_passwd")),
		DbUser(ctx.String("db_user")),
		Name(ctx.String("name")),
		Path(ctx.String("path")),
	)
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
		svcName:  opt.svcName,
		basePath: opt.basePath,
	}

	defer db.Close()
	if g.s, err = sql2pb.GenerateSchema(db, opt.model, opt.svcName, opt.svcName,
		opt.fieldStyle, opt.tablePrefix, nil, nil); err != nil {
		return nil, err
	}
	return g, nil
}

func (e *Generator) Create() error {

	fmt.Println("start gen " + e.svcName)
	// if cCtx.String("lang") != "table" {
	// 	//一般用不到者
	// 	e.genHandler()
	// }

	// e.genModel()
	return nil

}

func (e *Generator) genHandler() {
	t, _ := e.newTpl("proto.handler.tpl")
	var tf *os.File
	var err error

	if tf, err = e.createFile("pkg/proto/" + e.svcName + "_handler" + ".proto"); err != nil {
		panic(err)
	}
	if err := t.Execute(tf, e.s); err != nil {
		panic(err)
	}

	defer tf.Close()
}

// 生成模块
func (e *Generator) genModel() error {
	var tproto, tserver, trepository, trepoproto *template.Template
	var err error
	if tproto, err = e.newTpl("proto.model.tpl"); err != nil {
		return err
	}
	if tserver, err = e.newTpl("server.model.tpl"); err != nil {
		return err
	}
	if trepository, err = e.newTpl("repository.model.tpl"); err != nil {
		return err
	}
	if trepoproto, err = e.newTpl("repo-proto-model.tpl"); err != nil {
		return err
	}

	var tfproto, tfserver, tfrepository, tfrepoproto *os.File

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
		//.proto文件
		if tfproto, err = e.createFile("pkg/proto/" + e.svcName + "_" + fName + ".proto"); err != nil {
			return err
		}
		if err := tproto.Execute(tfproto, msg); err != nil {
			return err
		}
		//server/xxx.go文件
		if tfserver, err = e.createFile("internal/server/" + fName + ".go"); err != nil {
			return err
		}
		if err := tserver.Execute(tfserver, msg); err != nil {
			return err
		}
		//repository/mysql/xxx.go文件
		if tfrepository, err = e.createFile("internal/repository/mysql/" + fName + ".go"); err != nil {
			panic(err)
		}
		if err := trepository.Execute(tfrepository, msg); err != nil {
			panic(err)
		}
		//如果是全局构建，则不需要创建下面的东西
		if e.genType == "table" {

			if tfrepoproto, err = e.createFile(fName + ".mix"); err != nil {
				return err
			}
			if err := trepoproto.Execute(tfrepoproto, msg); err != nil {
				return err
			}
			defer tfrepoproto.Close()
		}

	}

	defer tfproto.Close()
	defer tfserver.Close()
	defer tfrepository.Close()
	//
	return nil
}

func (e *Generator) createFile(f string) (*os.File, error) {
	return os.Create(e.basePath + "/" + f)
}

func (e *Generator) newTpl(name string) (*template.Template, error) {
	return template.New(name).Funcs(template.FuncMap{
		"ucwords": Ucwords,
		"inc":     Inc,
		"topath":  ToPath,
	}).ParseFiles("templates/" + name)
}
