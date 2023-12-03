package main

import (
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
		Name:     "new",
		Usage:    "gostar generate tools",
		Flags:    generator.Flags,
		Action:   generator.Action,
		Commands: generator.Commands,
		Before:   generator.Before,
	}

	// app.Before = func(ctx *cli.Context) (err error) {
	// 	generator.Gtr, err = generator.NewCtx(ctx)
	// 	return
	// }

	if err := app.Run(os.Args); err != nil {
		log.Fatal(err)
	}
}
