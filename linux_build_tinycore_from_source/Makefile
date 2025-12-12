BZIMAGE_PATH := /Volumes/trash/trash/linux-6.12.11/arch/x86/boot/bzImage

run:	$(BZIMAGE_PATH)
	osascript -e 'display notification "To close Qemu, type Ctrl+A X" with title "QEMU tip"' -e 'delay 5' >/dev/null 2>&1 &
	qemu-system-x86_64 \
		-kernel $(BZIMAGE_PATH) \
		-initrd /Volumes/trash/trash/rootfs.cpio.gz \
		-m 512 \
		-nographic \
		-append "console=ttyS0 rdinit=/init debug"


all:	build

build:	$(BZIMAGE_PATH)

$(BZIMAGE_PATH):
	docker build -t tinycore-kernel-builder .	\
		&& docker rm -f kerneldebug1 2>/dev/null || true	\
		&& docker run --name kerneldebug1	\
			-v /Volumes/trash/trash:/out	\
			tinycore-kernel-builder		\
			make -f /build/Makefile_linux

download:
	echo "/Volumes/trash/trash/linux-6.12.11-patched.tar.xz"
