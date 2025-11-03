# Common variables
IMAGE_NAME = fuse-nfs-image
CONTAINER_NAME = fuse-nfs-test-c
MOUNT_DIR = /tmp/nfs-test-c
PORT = 2049

image:
	docker build -t $(IMAGE_NAME) .

build: image

run:
	docker stop $(CONTAINER_NAME) || echo ""
	docker rm $(CONTAINER_NAME) || echo ""
	# detached is hard to stop
	docker run -d --privileged -p $(PORT):$(PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME)

start: run

mount:
	mkdir -p $(MOUNT_DIR)
	sudo mount -t nfs -o vers=4,resvport,port=$(PORT) localhost:/ $(MOUNT_DIR) \
		&& find $(MOUNT_DIR) \
		&& echo "Works" \
		&& cat $(MOUNT_DIR)/hello

test:
	find $(MOUNT_DIR)
	cat $(MOUNT_DIR)/hello

stop:
	sudo umount -f $(MOUNT_DIR) || echo ""
	echo "pkill ganesha.nfsd && killall tail"
	echo "pkill ganesha.nfsd && killall tail"
	mount | grep nfs
# 	docker exec -it `docker ps -q -f ancestor=$(IMAGE_NAME)` bash
