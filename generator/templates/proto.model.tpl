syntax = "proto3";
package go.park.{{.ServiceName}}.v1;
 
option go_package = "pkg/pb/{{.ServiceName}}";

message {{ucwords .Name}} {
 {{range $k,$v:=.Fields}}{{if or  (eq $v.Name "ctm") (eq $v.Name "utm") (eq $v.Name "dtm")}} //@inject_tag: `gorm:"->"`
 {{end}} {{$v.Typ}} {{$v.Name}}={{inc $k}};//{{$v.Comment}}
 {{end}} 
}
message {{ucwords .Name}}CreateRequest{
 {{range $k,$v:=.Fields}}{{if and (ne $v.Name "ctm") (ne $v.Name "utm") (ne $v.Name "dtm") }} {{$v.Typ}} {{$v.Name}}={{inc $k}};
 {{end}}{{end}} 
}
message {{ucwords .Name}}UpdateRequest{
 {{range $k,$v:=.Fields}}{{if and (ne $v.Name "ctm") (ne $v.Name "utm") (ne $v.Name "dtm")}} //@inject_tag: mapstructure:",omitempty"`
 {{$v.Typ}} {{$v.Name}}={{inc $k}};
 {{end}}{{end}} 
}
message {{ucwords .Name}}DeleteRequest{
  uint32 id = 1;
}

message {{ucwords .Name}}FetchRequest{ 
 {{range $k,$v:=.Fields}}{{if and  (ne $v.Name "ctm") (ne $v.Name "utm") (ne $v.Name "dtm")}}{{$v.Typ}} {{$v.Name}}={{inc $k}};
 {{end}}{{end}}
  map<string, int64> tz = {{inc .FielNum}}; 
  uint32 p = {{inc .FielNum 2}}; 
  uint32 l = {{inc .FielNum 3}}; 
}


message {{ucwords .Name}}Response{
  int64 count = 1;
  repeated {{ucwords .Name}} data = 2;
}
 