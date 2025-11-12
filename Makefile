# Makefile for building the installer image
# Usage:
#   make docker            # build the docker image
#   make push              # push the image to registry (requires login)
#   make clean             # remove local image

IMAGE ?= registry-zhuoguang.siflow.cn/hisys/sicl-installer:25.11-1.cuda128-1
RUN_FILE ?= sicl-25.11-1.cuda128.ubuntu2004.run
DOCKERFILE ?= Dockerfile
BUILD_DIR ?= .

.PHONY: docker build push clean

docker: build

build:
	@echo "Building image $(IMAGE) with RUN_FILE=$(RUN_FILE)"
	docker build --build-arg RUN_FILE=$(RUN_FILE) -t $(IMAGE) -f $(DOCKERFILE) $(BUILD_DIR)

push:
	@echo "Pushing image $(IMAGE)"
	docker push $(IMAGE)

clean:
	@echo "Removing image $(IMAGE)"
	- docker rmi $(IMAGE)
