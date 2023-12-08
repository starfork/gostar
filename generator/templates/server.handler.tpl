package server

import ( 
	repo "service/{{.ServiceName}}/internal/repository" 
	"service/{{.ServiceName}}/internal/repository/mysql"

	pb "service/{{.ServiceName}}/pkg/pb"

	"github.com/starfork/stargo"
	"go.uber.org/zap"
)

type handler struct {
	logger *zap.SugaredLogger
	r      repo.{{ucwords .ServiceName}}Repository
	pb.Unimplemented{{ucwords .ServiceName}}HandlerServer
}

// New handler
func New(app *stargo.App) *handler {
	//logger :=

	return &handler{
		logger: app.GetLogger(),
		r:      mysql.New(app),
	}
}