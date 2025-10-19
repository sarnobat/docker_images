build:
# 	docker build --progress=plain -t fuse-nfs-booze-image --file Dockerfile.2025-10-18 .
	docker build --progress=plain -t fuse-nfs-booze-image --file Dockerfile .
	
run:
	docker stop fuse-nfs-booze  || echo ""
	docker rm fuse-nfs-booze || echo ""
	docker run -d --privileged --name fuse-nfs-booze fuse-nfs-booze-image
	docker ps
	docker exec -it fuse-nfs-booze find / -iname  "builtins.h"	| tee -a /tmp/docker_exec.out
	docker exec -it fuse-nfs-booze find / -iname  "bash.pc"		| tee -a /tmp/docker_exec.out
	docker exec -it fuse-nfs-booze find / -iname  "config.h"	| tee -a /tmp/docker_exec.out
	echo "========================== try this ==============================="
	echo "	cd /root/booze/ && bash hello.sh /tmp/test "
	echo "  cat /tmp/test/booze"
	echo "==================================================================="
	docker exec -it fuse-nfs-booze bash				| tee -a /tmp/docker_exec.out
# 	cd /root/booze/ && /usr/local/include/bash-5.2.21/bash booze.sh
# 	mkdir /tmp/test
# 	cd /root/booze/ && /usr/local/include/bash-5.2.21/bash hello.sh /tmp/test
# 	find /tmp/test
#	cat /tmp/test/booze
# 	ldd /root/booze/booze.so