package server

import (
	"context"
	pb "{{.ServiceName}}/pkg/pb"
)

func (e *handler) Fetch{{ucwords .Name}} (ctx context.Context, req *pb.{{ucwords .Name}}FetchRequest) (*pb.{{ucwords .Name}}Response, error) {
	return e.r.Fetch{{ucwords .Name}} (req) 
}

func (e *handler) Create{{ucwords .Name}} (ctx context.Context, req *pb.{{ucwords .Name}}CreateRequest) (*pb.{{ucwords .Name}}, error) {
	return e.r.Create{{ucwords .Name}} (req) 
}
func (e *handler) Update{{ucwords .Name}} (ctx context.Context, req *pb.{{ucwords .Name}}UpdateRequest) (*pb.{{ucwords .Name}}, error) {
	return e.r.Update{{ucwords .Name}} (req) 
}
func (e *handler) Delete{{ucwords .Name}} (ctx context.Context, req *pb.{{ucwords .Name}}DeleteRequest) (*pb.Response, error) {
	return  e.r.Delete{{ucwords .Name}} (req) 
}