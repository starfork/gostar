package server

import ( 
	repo "service/{{.ServiceName}}/internal/repository" 
	"service/{{.ServiceName}}/internal/repository/mysql"

	pb "service/{{.ServiceName}}/pkg/pb/v1" 

	"github.com/starfork/stargo"
	"github.com/starfork/stargo/logger"
)

type handler struct {
	logger logger.Logger
	r      repo.{{ucwords .ServiceName}}Repository
	pb.Unimplemented{{ucwords .ServiceName}}Server
}

// New handler
func New(app *stargo.App) *handler {
	//logger :=

	return &handler{
		logger: app.GetLogger(),
		r:      mysql.New(app),
	}
}