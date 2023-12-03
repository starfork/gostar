package main

import (
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/starfork/gostar/generator"
	"github.com/urfave/cli/v2"

	"github.com/joho/godotenv"
)

type Driver struct {
	Lang string
}

func main() {
	godotenv.Load(".env.development")

	//var gtr *generator.Generator
	app := cli.App{
		Name:  "new",
		Usage: "gostar generate tools",
		Flags: generator.Flags,
		Action: func(ctx *cli.Context) error {
			fmt.Println("start gen root")

			return nil
		},
		Commands: generator.Commands,
	}

	app.Before = func(ctx *cli.Context) (err error) {
		//gtr, err = generator.NewCtx(ctx)
		return
	}

	if err := app.Run(os.Args); err != nil {
		log.Fatal(err)
	}
}

// func main() {
// 	app := &cli.App{
// 		EnableBashCompletion: true,
// 		Commands: []*cli.Command{
// 			{
// 				Name:    "add",
// 				Aliases: []string{"a"},
// 				Usage:   "add a task to the list",
// 				Action: func(cCtx *cli.Context) error {
// 					fmt.Println("added task: ", cCtx.Args().First())
// 					return nil
// 				},
// 			},
// 			{
// 				Name:    "complete",
// 				Aliases: []string{"c"},
// 				Usage:   "complete a task on the list",
// 				Action: func(cCtx *cli.Context) error {
// 					fmt.Println("completed task: ", cCtx.Args().First())
// 					return nil
// 				},
// 			},
// 			{
// 				Name:    "template",
// 				Aliases: []string{"t"},
// 				Usage:   "options for task templates",
// 				Subcommands: []*cli.Command{
// 					{
// 						Name:  "add",
// 						Usage: "add a new template",
// 						Action: func(cCtx *cli.Context) error {
// 							fmt.Println("new task template: ", cCtx.Args().First())
// 							return nil
// 						},
// 					},
// 					{
// 						Name:  "remove",
// 						Usage: "remove an existing template",
// 						Action: func(cCtx *cli.Context) error {
// 							fmt.Println("removed task template: ", cCtx.Args().First())
// 							return nil
// 						},
// 					},
// 				},
// 			},
// 		},
// 	}

// 	if err := app.Run(os.Args); err != nil {
// 		log.Fatal(err)
// 	}
// }
