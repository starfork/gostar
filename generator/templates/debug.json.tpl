{
    "server": {
        "environment": "debug",
        "port": ":51100",
        "timezome": "Asia/Shanghai",
        "mysql": {
            "debug": true,
            "name": "{{.ServiceName}}",
            "user": "{{.ServiceName}}",
            "host": "127.0.0.1",
            "port": "3306",
            "password": "",
            "tableprefix": "{{.ServiceName}}_"
        },
        "registry": {
            "org": "park",
            "name": "redis",
            "addr": "127.0.0.1:6379",
            "environment": "debug"
        }
    }
}