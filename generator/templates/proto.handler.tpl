syntax = "proto3";
package go.park.{{.ServiceName}}.v1;
{{- range .Messages}}
import "service/{{$.ServiceName}}/pkg/proto/{{lower .Name}}.proto";
{{- end}} 
option go_package = "service/{{$.ServiceName}}/pkg/pb/v1"; 

service {{ucwords .ServiceName}} {
    {{range .Messages}}
    //{{ucwords .Name}}
    rpc Create{{ucwords .Name}}({{ucwords .Name}}CreateRequest) returns ({{ucwords .Name}}) {}
    rpc Fetch{{ucwords .Name}}({{ucwords .Name}}FetchRequest) returns ({{ucwords .Name}}Response) {}
    rpc Update{{ucwords .Name}}({{ucwords .Name}}UpdateRequest) returns ({{ucwords .Name}}) {} 
    rpc Delete{{ucwords .Name}}({{ucwords .Name}}DeleteRequest) returns (Response) {} 
    {{ end}}  

}

message Empty {}
message Response { string msg = 2; }