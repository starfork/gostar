syntax = "proto3";
package go.park.{{.ServiceName}};
 
option go_package = "pkg/pb/{{.ServiceName}}";

 
message {{ucwords .Name}} {
    {{range $k,$v:=.Fields}}{{$v.Typ}} {{$v.Name}}={{inc $k}};//{{$v.Comment}}
    {{end}} 
}
message {{ucwords .Name}}CreateRequest{
    {{range $k,$v:=.Fields}}{{$v.Typ}} {{$v.Name}}={{inc $k}};//{{$v.Comment}}
    {{end}} 
}
message {{ucwords .Name}}UpdateRequest{
    {{range $k,$v:=.Fields}}{{$v.Typ}} {{$v.Name}}={{inc $k}};//{{$v.Comment}}
    {{end}} 
}
message {{ucwords .Name}}DeleteRequest{
    uint32 id = 1;
}

message {{ucwords .Name}}FetchRequest{ 
    {{range $k,$v:=.Fields}}{{$v.Typ}} {{$v.Name}}={{inc $k}};//{{$v.Comment}}
    {{end}} 
    map<string, int64> tz = {{inc .FielNum}}; 
    uint32 p = {{inc .FielNum 2}}; 
    uint32 l = {{inc .FielNum 3}}; 
}


message {{ucwords .Name}}Response{
    int64 count = 1;
    repeated {{ucwords .Name}} data = 2;
}
 