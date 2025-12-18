DOCKER_IMAGE := rootfs-builder
DOCKERFILE   := Dockerfile_rootfs
OUT_DIR := /Volumes/trash/trash

all:	build

build:	bzImage
	brew install qemu

bzImage:
	docker build -t tinycore-kernel-builder .	\
		&& docker rm -f kerneldebug1 2>/dev/null || true	\
		&& docker run --name kerneldebug1	\
			-v /Volumes/trash/trash:/out	\
			tinycore-kernel-builder		\
			make -f /build/Makefile_linux

download:
	
	test -f "/Volumes/trash/trash/linux-6.12.11-patched.tar.xz" || echo "cd /Volumes/trash/trash/ && wget http://www.tinycorelinux.net/16.x/x86/release/src/kernel/linux-6.12.11-patched.tar.xz"
	test -d "/Volumes/trash/trash/linux-6.12.11" || echo "cd /Volumes/trash/trash/ && tar xvf linux-6.12.11-patched.tar.xz"

run:	bzImage	rootfs.cpio.gz
	qemu-system-x86_64 \
		-kernel /Volumes/trash/trash/linux-6.12.11/arch/x86/boot/bzImage \
		-initrd /Volumes/trash/trash/rootfs.cpio.gz \
		-m 512 \
		-nographic \
		-append "console=ttyS0 rdinit=/init debug"


.PHONY: docker-image

docker-image:
	docker build \
		-f $(DOCKERFILE) \
		-t $(DOCKER_IMAGE) \
		.

rootfs.cpio.gz:
	docker run --rm \
		-v "$(PWD):/work" \
		-v "$(OUT_DIR):/out" \
		$(DOCKER_IMAGE)
