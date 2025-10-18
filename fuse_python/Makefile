build:
	docker stop fuse-nfs-python  || echo ""
	docker rm fuse-nfs-python || echo ""
# 	docker build -t fuse-nfs-image .
	# detached is hard to stop
	docker run -d --privileged -p 2049:2049 --name fuse-nfs-python fuse-nfs
	mkdir -p /tmp/nfs-test
	sudo mount -t nfs -o vers=4,resvport,port=2049 localhost:/ /tmp/nfs-test && find /tmp/nfs-test && echo "Works"

run:
	find /tmp/nfs-test
	cat  /tmp/nfs-test/hello

stop:
	echo "pkill ganesha.nfsd && killall tail"
	echo "pkill ganesha.nfsd && killall tail"
	docker exec -it `docker ps -q -f ancestor=fuse-nfs` bash
	
