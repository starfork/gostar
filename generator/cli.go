package generator

import (
	"fmt"

	"github.com/urfave/cli/v2"
)

//var Flags=

var Action = func(ctx *cli.Context) error {
	fmt.Println("start gen root")
	//fmt.Println(gtr.Create())
	fmt.Println("end gen root")
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
}
var Commands = []*cli.Command{
	{
		Name:     "api",
		Usage:    "generate api files",
		Category: "new",
		Action: func(cCtx *cli.Context) error {
			//return genApis()
			fmt.Println("gen api")
			return nil
		},
	},
	{
		Name:     "handler",
		Category: "new",
		Usage:    "generate handler",
		Action: func(cCtx *cli.Context) error {
			fmt.Println("gen handler")
			return nil
		},
	},
}

func Before(ctx *cli.Context) (err error) {
	//	gtr, err = NewCtx(ctx)
	return

}
