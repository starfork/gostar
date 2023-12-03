
{{range .}}
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
{{ end}}  