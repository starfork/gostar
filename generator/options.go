package generator

type Options struct {
	dbType   string //数据库类型
	dbName   string //数据库名字
	dbPasswd string //数据密码
	dbUser   string //数据用户
	dbHost   string // db host
	dbPort   string // db port

	fieldStyle string //字段风格

	tableName string

	svcName     string
	models      string
	basePath    string
	tablePrefix string
}
type Option func(o *Options)

func DbName(c string) Option {
	return func(o *Options) {
		o.dbName = c
	}
}
func DbPasswd(c string) Option {
	return func(o *Options) {
		o.dbPasswd = c
	}
}
func DbUser(c string) Option {
	return func(o *Options) {
		o.dbUser = c
	}
}
func DbHost(c string) Option {
	return func(o *Options) {
		o.dbHost = c
	}
}

// DB port
func DbPort(c string) Option {
	return func(o *Options) {
		o.dbPort = c
	}
}

// Service Name
func Name(c string) Option {
	return func(o *Options) {
		o.svcName = c
	}
}

// Project base path
func Path(c string) Option {
	return func(o *Options) {
		o.basePath = c
	}
}

func Models(c string) Option {
	return func(o *Options) {
		o.models = c
	}
}

func Prefix(c string) Option {
	return func(o *Options) {
		o.tablePrefix = c
	}
}

// DefaultOptions default options
func DefaultOptions() Options {
	o := Options{
		dbType:     "mysql", //目前只实现了这个
		fieldStyle: "sqlPb", //目前只实现了这个
		dbName:     "stargo",
		dbUser:     "root",
		dbPort:     "3306",
		dbHost:     "127.0.0.1",

		tableName: "stargo",
		svcName:   "",
	}
	return o
}
