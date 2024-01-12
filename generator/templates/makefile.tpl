#all 只能执行build，dev，test，
#proto 一般都是在本地运行，线上不搭配protoc环境。只负责build到docker

#export GOPROXY=https://goproxy.cn

#构建名称。all，或者api名称或者service名称
NAME = {{.ServiceName}}
#docker中对应的名称api-xxx或者srv-xxx
D_NAME = srv-{{.ServiceName}}
#docker 端口 
D_PORT = 51900
#main.go 所在目录
CMD_PATH = ./cmd/server/
ORG_NAME = go-park



.PHONY: go-park proto build

update:
	git pull 
 

proto:
	$(eval D_IMAGE=$(ORG_NAME)-$(D_NAME))
	$(call build_service_proto)

build: 
	$(call build_docker)
b: 
	$(call build_docker)
 
test: #测试
	@cd $(CMD_PATH)  && go run main.go

dev: # 执行默认mac策略
	$(eval CONFIG_PATH=$(PWD)/config)
	$(call run_docker)
prod: #linux docker/deepin,centos  
	$(eval CONFIG_PATH=/www/etc/$(ORG_NAME)/)
	$(call run_docker)
p: #linux docker/deepin,centos  
	$(eval CONFIG_PATH=/www/etc/$(ORG_NAME)/)
	$(call run_docker)


#基础镜像
go-park:
	docker build -f ../../park-pkg/assets/docker/$(ORG_NAME)  -t starfork/$(ORG_NAME) .
#docker网络
network:
	docker network create $(ORG_NAME)

nats:
	docker run -d --name nats --network go-park -p 4222:4222 -p 6222:6222 -p 8222:8222 nats
 
#protoc --proto_path=./   --go-grpc_out=../pb --go_out=../pb ./*.proto  
#构建proto
define  build_service_proto   
	$(eval PKG_PATH=./pkg) 
	@rm -rf $(PKG_PATH)/pb/$(NAME)/v1/*
	@protoc --proto_path=../../ \
	-I=../../park-pkg/proto/ \
	--go-grpc_out=$(PKG_PATH)/pb \
	--go_out=$(PKG_PATH)/pb  \
	../../service/$(NAME)/pkg/proto/*.proto  
	@protoc-go-inject-tag -input=$(PKG_PATH)/pb/$(NAME)/v1/*.pb.go  
endef 

##在此之前需要完成proto构建
define build_docker 
	$(eval D_IMAGE=$(ORG_NAME)-$(D_NAME))
	GOOS=linux CGO_ENABLED=0 GOARCH=amd64 go build -ldflags="-s -w" -installsuffix cgo -o ./$(D_IMAGE) $(CMD_PATH)main.go
	-docker stop $(D_IMAGE)
	-docker rm $(D_IMAGE)
	-docker rmi starfork/$(D_IMAGE)
	-docker build --build-arg dname=${D_NAME} --build-arg dport=${D_PORT} -f ../../park-pkg/assets/docker/Dockerfile -t starfork/$(D_IMAGE) .
	rm ./$(D_IMAGE)
endef 

#docker run -d --name srv-park-all --network go-park --network-alias srv-park-all -p 51000:51000 starfork/go-park-all
define 	run_docker   
	$(eval D_IMAGE=$(ORG_NAME)-$(D_NAME)) 
	-docker stop $(D_NAME)
	-docker rm $(D_NAME)
	docker run -d --name $(D_NAME) --network $(ORG_NAME) -v $(CONFIG_PATH):/$(ORG_NAME)/config --entrypoint ./$(D_IMAGE) --network-alias $(D_IMAGE) -p $(D_PORT):$(D_PORT) starfork/$(D_IMAGE) -c config/docker.yaml
endef
 