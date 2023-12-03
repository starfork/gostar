 

//Repository 函数定义
Create{{ucwords .Name}}(*pb.{{ucwords .Name}}CreateRequest) (*pb.{{ucwords .Name}}, error)
Update{{ucwords .Name}}(*pb.{{ucwords .Name}}UpdateRequest) (*pb.{{ucwords .Name}}, error)
Delete{{ucwords .Name}}(*pb.{{ucwords .Name}}DeleteRequest) (*pb.Response, error) 
Fetch{{ucwords .Name}}(*pb.{{ucwords .Name}}FetchRequest) (*pb.{{ucwords .Name}}Response, error)
Read{{ucwords .Name}}(*pb.{{ucwords .Name}}FetchRequest) (*pb.{{ucwords .Name}}, error)

//proto handler里的函数定义


rpc Create{{ucwords .Name}}({{ucwords .Name}}CreateRequest) returns ({{ucwords .Name}}) {}
rpc Fetch{{ucwords .Name}}({{ucwords .Name}}FetchRequest) returns ({{ucwords .Name}}Response) {}
rpc Update{{ucwords .Name}}({{ucwords .Name}}UpdateRequest) returns ({{ucwords .Name}}) {} 
rpc Delete{{ucwords .Name}}({{ucwords .Name}}DeleteRequest) returns (Response) {} 
rpc Read{{ucwords .Name}}({{ucwords .Name}}FetchRequest) returns  ({{ucwords .Name}}) {}
 


//api 定义

  - selector: go.park.{{.ServiceName}}.{{ucwords .ServiceName}}Handler.Fetch{{ucwords .Name}}
    get: "/v1/{{.ServiceName}}/{{topath .Name}}s"  
  - selector: go.park.{{.ServiceName}}.{{ucwords .ServiceName}}Handler.Read{{ucwords .Name}}
    get: "/v1/{{.ServiceName}}/{{topath .Name}}"  
  - selector: go.park.{{.ServiceName}}.{{ucwords .ServiceName}}Handler.Create{{ucwords .Name}}
    post: "/v1/{{.ServiceName}}/{{topath .Name}}"
    body: "*"  
  - selector: go.park.{{.ServiceName}}.{{ucwords .ServiceName}}Handler.Update{{ucwords .Name}}
    put: "/v1/{{.ServiceName}}/{{topath .Name}}"  
    body: "*"  
  - selector: go.park.{{.ServiceName}}.{{ucwords .ServiceName}}Handler.Delete{{ucwords .Name}}
    delete: "/v1/{{.ServiceName}}/{{topath .Name}}" 


//js 方法

export function fetch{{ucwords .Name}} (data) {
    return get('{{.ServiceName}}/{{topath .Name}}s', data)
}
export function read{{ucwords .Name}} (data) {
    return get('{{.ServiceName}}/{{topath .Name}}', data)
}
export function create{{ucwords .Name}} (data) {
    return post('{{.ServiceName}}/{{topath .Name}}', data)
}
export function update{{ucwords .Name}} (data) {
    return put('{{.ServiceName}}/{{topath .Name}}', data)
}
export function delete{{ucwords .Name}} (data) {
    return del('{{.ServiceName}}/{{topath .Name}}', data)
}
