MOUNT_POINT = /tmp/nfs-test-c
NFS_MOUNT_OPTIONS = vers=4,resvport,port=2049,soft,timeo=2,retrans=1

image:
	docker build -t fuse-nfs-image .
	
build:	image



run:
	docker stop fuse-nfs-test-c  || echo ""
	docker rm fuse-nfs-test-c || echo ""
	# detached is hard to stop
	docker run -d --privileged -p 2049:2049 --name fuse-nfs-test-c fuse-nfs-image

start:	run	

ensure-mounted:
	mkdir -p $(MOUNT_POINT)
	mount | grep -q '$(MOUNT_POINT)' || sudo mount -t nfs -o $(NFS_MOUNT_OPTIONS) localhost:/ $(MOUNT_POINT)

mount: ensure-mounted
	find $(MOUNT_POINT) \
		&& echo "Works" \
		&& cat  $(MOUNT_POINT)/hello

test: ensure-mounted
	find $(MOUNT_POINT)
	cat  $(MOUNT_POINT)/hello

stop:
	sudo umount -f $(MOUNT_POINT) || echo ""
	echo "pkill ganesha.nfsd && killall tail"
	echo "pkill ganesha.nfsd && killall tail"
	mount | grep nfs
# 	docker exec -it `docker ps -q -f ancestor=fuse-nfs` bash
	
