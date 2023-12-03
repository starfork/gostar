package server

import (
	"public/pkg/app"
	repo "{{.ServiceName}}/internal/repository"
	pb "{{.ServiceName}}/pkg/pb"

	"go.uber.org/zap"
)

type handler struct {
	logger *zap.SugaredLogger
	r      repo.{{ucwords .ServiceName}}Repository
	pb.Unimplemented{{ucwords .ServiceName}}HandlerServer
}

// New handler
func New(app *app.App) *handler {
	//logger :=

	return &handler{
		logger: app.GetLogger(),
		r:      repo.New(app),
	}
}