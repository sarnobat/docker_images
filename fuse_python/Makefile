image:
	docker build -t fuse-nfs-image-python . 2>&1| tee /tmp/docker.log

build:	image

run:
	sudo umount -f /tmp/nfs-test-python || echo ""
	docker stop fuse-nfs-python  || echo ""
	docker rm fuse-nfs-python || echo ""
	rmdir /tmp/nfs-test-python || echo ""
	# detached is hard to stop
	docker run -d --privileged -p 2051:2051 --name fuse-nfs-python fuse-nfs-image-python

start:	run

mount:
	mkdir -p /tmp/nfs-test-python
	sudo mount -t nfs -o vers=4,resvport,port=2051 localhost:/ /tmp/nfs-test-python 

test:
	#&& find /tmp/nfs-test-python && echo "Works" && cat /tmp/nfs-test-python/hello
	find /tmp/nfs-test-python
	cat  /tmp/nfs-test-python/hello

debug:
# 	docker run -it --privileged --entrypoint bash fuse-nfs-image-python
	docker exec -it fuse-nfs-python tail -100f /var/log/ganesha.log

stop:
	sudo umount -f /tmp/nfs-test-python || echo ""
	docker stop fuse-nfs-python
	docker rm fuse-nfs-python
	mount | grep python
	docker ps

stop_nfs:
	echo "pkill ganesha.nfsd && killall tail"
	echo "pkill ganesha.nfsd && killall tail"
	docker exec -it `docker ps -q -f ancestor=fuse-nfs-python` bash
	
