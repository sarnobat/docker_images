image:
	docker build -t fuse-nfs-image .
	
build:	image

run:
	docker stop fuse-nfs-test-c  || echo ""
	docker rm fuse-nfs-test-c || echo ""
	# detached is hard to stop
	docker run -d --privileged -p 2049:2049 --name fuse-nfs-test-c fuse-nfs-image
	mkdir -p /tmp/nfs-test-c
	sudo mount -t nfs -o vers=4,resvport,port=2049 localhost:/ /tmp/nfs-test-c \
		&& find /tmp/nfs-test-c \
		&& echo "Works" \
		&& cat  /tmp/nfs-test-c/hello


test:
	find /tmp/nfs-test-c
	cat  /tmp/nfs-test-c/hello

stop:
	echo "pkill ganesha.nfsd && killall tail"
	echo "pkill ganesha.nfsd && killall tail"
	docker exec -it `docker ps -q -f ancestor=fuse-nfs` bash
	
