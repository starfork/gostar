### gostar

a generator for stargo


#### Installation

```
go install  github.com/starfork/gostar@latest
```

#### Usage

Set DB env info in .env.development or just by os.Args

example:

```
gostar gen|new -n=test -pfx=test_
```

If no error occurr you'll get this folders(files) 

```

├── Makefile
├── cmd
│   └── main.go  
├── config
│   └── debug.json
├── internal
│   ├── codes
│   ├── consts
│   ├── logic
│   ├── repository
│   │   ├── mysql
│   │   └── repository.go
│   └── server
│       ├── handler.go
│       └── server_config.go
└── pkg
    ├── pb
    └── proto
```