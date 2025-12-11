all:	build

build:	bzImage

bzImage:
	docker build -t tinycore-kernel-builder .	\
		&& docker rm -f kerneldebug1 2>/dev/null || true	\
		&& docker run --name kerneldebug1	\
			-v /Volumes/trash/trash:/out	\
			tinycore-kernel-builder		\
			make -f /build/Makefile_linux

download:
	echo "/Volumes/trash/trash/linux-6.12.11-patched.tar.xz"

run:	bzImage

	qemu-system-x86_64 \
		-kernel /Volumes/trash/trash/linux-6.12.11/arch/x86/boot/bzImage \
		-initrd /Volumes/trash/trash/rootfs.cpio.gz \
		-m 512 \
		-nographic \
		-append "console=ttyS0 rdinit=/init debug"