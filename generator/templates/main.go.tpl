package main

import (
	"flag"
	"service/{{.ServiceName}}/internal/server"
	pb "service/{{.ServiceName}}/pkg/pb/v1" 

	"github.com/joho/godotenv"
	"github.com/starfork/stargo"
)

func main() {
	_ = godotenv.Load("../../config/.env.development")
	cf := flag.String("c", "../../config/debug.yaml", "config file path")
	flag.Parse()
	sc := server.LoadConfig(*cf)
	app := stargo.New(
		stargo.Org("park"),
		stargo.Name("{{.ServiceName}}"),
		stargo.Config(sc.Server),
	)

	pb.Register{{ucwords .ServiceName}}Server(app.Server(), server.New(app))

	app.Run()

}
