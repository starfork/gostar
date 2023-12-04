package repository

import ( 
 
    pb "service/{{.ServiceName}}/pkg/pb"
)

 
type {{ucwords .ServiceName}}Repository interface {
    {{range .Messages}}
    //{{ucwords .Name}}
    Create{{ucwords .Name}}(*pb.{{ucwords .Name}}CreateRequest) (*pb.{{ucwords .Name}}, error)
    Update{{ucwords .Name}}(*pb.{{ucwords .Name}}UpdateRequest) (*pb.{{ucwords .Name}}, error)
    Delete{{ucwords .Name}}(*pb.{{ucwords .Name}}DeleteRequest) (*pb.Response, error) 
	Fetch{{ucwords .Name}}(*pb.{{ucwords .Name}}FetchRequest) (*pb.{{ucwords .Name}}Response, error)
    {{ end}} 

}



 


