build:
# 	docker build -t fuse-nfs-booze-image --file Dockerfile.2025-10-18 .
	docker build -t fuse-nfs-booze-image --file Dockerfile .
	
run:
	docker stop fuse-nfs-booze  || echo ""
	docker rm fuse-nfs-booze || echo ""
	docker run -d --privileged --name fuse-nfs-booze fuse-nfs-booze-image
	docker ps
	docker exec -it fuse-nfs-booze find / -iname  "builtins.h"
	docker exec -it fuse-nfs-booze find / -iname  "config.h"
	docker exec -it fuse-nfs-booze bash