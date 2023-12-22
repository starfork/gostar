package main

import (
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	"github.com/starfork/gostar/generator"
	"github.com/urfave/cli/v2"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	godotenv.Load(".env.development")

	app := &cli.App{
		Name:  "gostar",
		Usage: "stargo tools collection",
		Commands: []*cli.Command{
			{
				Name:        "new",
				Usage:       "create project files",
				Flags:       generator.Flags,
				Aliases:     []string{"gen"},
				Before:      generator.Before,
				Action:      generator.Action,
				Subcommands: generator.Subcommands(),
			},
			{
				Name:  "other",
				Usage: "other funcs to be implement",
				Action: func(ctx *cli.Context) error {
					fmt.Println("to be implement")
					return nil
				},
			},
		},
	}

	app.Suggest = true
	if err := app.Run(os.Args); err != nil {
		log.Fatal(err)
	}
}
