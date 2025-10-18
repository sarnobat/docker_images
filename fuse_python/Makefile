build:
	docker stop fuse-nfs-python  || echo ""
	docker rm fuse-nfs-python || echo ""
	# detached is hard to stop
	docker run -d --privileged -p 2049:2049 --name fuse-nfs-python fuse-nfs-image-python
	mkdir -p /tmp/nfs-test
	sudo mount -t nfs -o vers=4,resvport,port=2049 localhost:/ /tmp/nfs-test && find /tmp/nfs-test && echo "Works"

image:
	docker build -t fuse-nfs-image-python . 2>&1| tee /tmp/docker.log

run:
	find /tmp/nfs-test
	cat  /tmp/nfs-test/hello

debug:
	docker run -it --privileged --entrypoint bash fuse-nfs-image-python

stop:
	echo "pkill ganesha.nfsd && killall tail"
	echo "pkill ganesha.nfsd && killall tail"
	docker exec -it `docker ps -q -f ancestor=fuse-nfs-python` bash
	
