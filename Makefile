IMAGE_NAME=tf_sshd
APP_NAME=tf3-pycharm
HOST_PORT=8888
GPUS='4,5'

build:
	docker build -t $(IMAGE_NAME) .

run: build
	NV_GPU=$(GPUS) nvidia-docker run -d -p 8888:22 --name $(APP_NAME) -v $(shell pwd)/src:/root/src $(IMAGE_NAME) 

test: run
	docker port $(APP_NAME) 22

stop:
	docker stop $(APP_NAME); docker rm $(APP_NAME)

clean: stop
	docker rmi $(IMAGE_NAME)
