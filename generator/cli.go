package generator

import (
	"fmt"

	"github.com/urfave/cli/v2"
)

//var Flags=

var Action = func(ctx *cli.Context) error {
	//传递model的时候不生成特殊文件

	if ctx.String("model") == "" {
		Gtr.Folders()
		Gtr.SpecificFiles()
	}
	Gtr.Models()

	fmt.Println("job done!")
	return nil
}
var Flags = []cli.Flag{
	&cli.StringFlag{
		Name:     "db_host",
		Usage:    "database host",
		EnvVars:  []string{"DB_HOST"},
		Required: true,
	},
	&cli.StringFlag{
		Name:     "db_name",
		Usage:    "database name",
		EnvVars:  []string{"DB_NAME"},
		Required: true,
	},
	&cli.StringFlag{
		Name:     "db_passwd",
		Usage:    "database passwd",
		EnvVars:  []string{"DB_PASSWD"},
		Required: true,
	},
	&cli.StringFlag{
		Name:     "db_user",
		Usage:    "language for the greeting",
		EnvVars:  []string{"DB_USER"},
		Required: true,
	},
	&cli.StringFlag{
		Name:     "name",
		Usage:    "service name",
		Aliases:  []string{"n"},
		Required: true,
	},
	&cli.StringFlag{
		Name:    "path",
		Value:   "./",
		Aliases: []string{"p"},
		Usage:   "base path",
	},
	&cli.StringFlag{
		Name:    "prefix",
		Aliases: []string{"pfx"},
		Usage:   "table prefix",
	},
	&cli.StringFlag{
		Name:    "model",
		Aliases: []string{"m"},
		Usage:   "models specific",
	},
}
var Commands = []*cli.Command{
	{
		Name:  "api",
		Usage: "generate api files",
		//Category: "new",
		Action: func(ctx *cli.Context) error {
			//return genApis()=
			fmt.Println("gen api")
			return nil
		},
	},
	{
		Name: "handler",
		//Category: "new",
		Usage: "generate handler",
		Action: func(ctx *cli.Context) error {
			fmt.Println("gen handler")
			return nil
		},
	},
}

func Before(ctx *cli.Context) (err error) {
	Gtr, err = New(
		DbHost(ctx.String("db_host")),
		DbName(ctx.String("db_name")),
		DbPasswd(ctx.String("db_passwd")),
		DbUser(ctx.String("db_user")),
		Name(ctx.String("name")),
		Path(ctx.String("path")),
		Models(ctx.String("model")), //tables
	)

	return
}

// 往上层传递，带上分类
func Subcommands() []*cli.Command {
	cmds := Commands
	for _, v := range cmds {
		v.Category = "new"
	}
	return cmds
}
