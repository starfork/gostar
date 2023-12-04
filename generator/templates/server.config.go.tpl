package server

import (
	"os"

	jsoniter "github.com/json-iterator/go"
	"github.com/starfork/stargo/config"
)

// 当前服务配置
type ServiceConfig struct {
	Server *config.Config
}

func LoadConfig(f string) *ServiceConfig {
	conf := &ServiceConfig{}
	file, err := os.Open(f)
	if err != nil {
		panic(err)
	}
	defer file.Close()
	decoder := jsoniter.NewDecoder(file)
	if err = decoder.Decode(&conf); err != nil {
		panic(err)
	}
	return conf
}
