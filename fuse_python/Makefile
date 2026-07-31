MOUNT_POINT = /tmp/nfs-test-python
NFS_MOUNT_OPTIONS = vers=4,resvport,port=2051,soft,timeo=2,retrans=1

image:
	docker build -t fuse-nfs-image-python . 2>&1| tee /tmp/docker.log

build:	image

run:
	sudo umount -f $(MOUNT_POINT) || echo ""
	docker stop fuse-nfs-python  || echo ""
	docker rm fuse-nfs-python || echo ""
	rmdir $(MOUNT_POINT) || echo ""
	# detached is hard to stop
	docker run -d --privileged -p 2051:2051 --name fuse-nfs-python fuse-nfs-image-python

start:	run

ensure-mounted:
	mkdir -p $(MOUNT_POINT)
	mount | grep -q '$(MOUNT_POINT)' || sudo mount -t nfs -o $(NFS_MOUNT_OPTIONS) localhost:/ $(MOUNT_POINT)

mount: ensure-mounted
	find $(MOUNT_POINT) \
		&& echo "Works" \
		&& cat $(MOUNT_POINT)/hello

test: ensure-mounted
	#&& find /tmp/nfs-test-python && echo "Works" && cat /tmp/nfs-test-python/hello
	find $(MOUNT_POINT)
	cat  $(MOUNT_POINT)/hello

debug:
# 	docker run -it --privileged --entrypoint bash fuse-nfs-image-python
	docker exec -it fuse-nfs-python tail -100f /var/log/ganesha.log

stop:
	sudo umount -f $(MOUNT_POINT) || echo ""
	docker stop fuse-nfs-python || echo ""
	docker rm fuse-nfs-python || echo ""
	mount | grep python || echo ""
	docker ps

stop_nfs:
	echo "pkill ganesha.nfsd && killall tail"
	echo "pkill ganesha.nfsd && killall tail"
	docker exec -it `docker ps -q -f ancestor=fuse-nfs-python` bash
	
