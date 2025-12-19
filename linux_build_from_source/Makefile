DOCKER_IMAGE := rootfs-builder
DOCKERFILE   := Dockerfile_rootfs

/Volumes/git/github/linux/arch/x86/boot/bzImage:
# 	cd /Volumes/git/github/ && ln -sf linux linux-6.12.11
	docker build -t tinycore-kernel-builder .	\
		&& docker rm -f kerneldebug 2>/dev/null || true	\
		&& docker run --name kerneldebug	\
			-v /Volumes/git/github/:/out	\
			tinycore-kernel-builder		\
			make -f /build/Makefile_linux


build:	/Volumes/git/github/linux/arch/x86/boot/bzImage

checkout:
	cd /Volumes/git/github/linux/ && git checkout v6.12


run:	/Volumes/git/github/linux/arch/x86/boot/bzImage	rootfs.cpio.gz

	@echo "Try and get this to work with vanilla linux github repo, not tinycore linux archive"

	qemu-system-x86_64 \
		-kernel /Volumes/git/github/linux/arch/x86/boot/bzImage \
		-initrd rootfs.cpio.gz \
		-m 512 \
		-nographic \
		-append "console=ttyS0 rdinit=/init debug"

.PHONY: docker-image

docker-image:
	docker image rm $(DOCKER_IMAGE) || true
	docker build \
		-f $(DOCKERFILE) \
		-t $(DOCKER_IMAGE) \
		.

rootfs.cpio.gz:
	docker run --rm \
		-v "$(PWD):/work" \
		-v /Volumes/trash/trash:/out	\
		$(DOCKER_IMAGE)
	rm -rf build

