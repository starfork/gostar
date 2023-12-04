syntax = "proto3";
package go.park.{{.ServiceName}};
{{- range .Messages}}
import "{{$.ServiceName}}_{{lower .Name}}.proto";
{{- end}}
option go_package = "pkg/pb;{{.ServiceName}}";

service {{.ServiceName}}Handler {
    {{range .Messages}}
    //{{ucwords .Name}}
    rpc Create{{ucwords .Name}}({{ucwords .Name}}CreateRequest) returns ({{ucwords .Name}}) {}
    rpc Fetch{{ucwords .Name}}({{ucwords .Name}}FetchRequest) returns ({{ucwords .Name}}Response) {}
    rpc Update{{ucwords .Name}}({{ucwords .Name}}UpdateRequest) returns ({{ucwords .Name}}) {} 
    rpc Delete{{ucwords .Name}}({{ucwords .Name}}DeleteRequest) returns (Response) {} 
    {{ end}}  

}

message Empty {}
message Response { string message = 2; }