BZIMAGE_PATH := /Volumes/trash/trash/linux-6.12.11/arch/x86/boot/bzImage
DOCKER_IMAGE := rootfs-builder
DOCKERFILE   := Dockerfile_rootfs

OUT_DIR := /Volumes/trash/trash

all:	build

build:	$(BZIMAGE_PATH)
	brew install qemu

$(BZIMAGE_PATH):
	docker build -t tinycore-kernel-builder .	\
		&& docker rm -f kerneldebug1 2>/dev/null || true	\
		&& docker run --name kerneldebug1	\
			-v /Volumes/trash/trash:/out	\
			tinycore-kernel-builder		\
			make -f /build/Makefile_linux

download:
	echo "/Volumes/trash/trash/linux-6.12.11-patched.tar.xz"
	test -f "/Volumes/trash/trash/linux-6.12.11-patched.tar.xz" || echo "cd /Volumes/trash/trash/ && wget http://www.tinycorelinux.net/16.x/x86/release/src/kernel/linux-6.12.11-patched.tar.xz"
	test -d "/Volumes/trash/trash/linux-6.12.11" || echo "cd /Volumes/trash/trash/ && tar xvf linux-6.12.11-patched.tar.xz"

.PHONY: info

info:

	@echo ""
	@echo "bzImage"
	@echo "├── vmlinux"
	@echo "│   ├── vmlinux.o"
	@echo "│   │   ├── built-in.a"
	@echo "│   │   └── arch/x86/kernel/built-in.a"
	@echo "│   └── vmlinux.a"
	@echo "│       ├── init/built-in.a"
	@echo "│       ├── kernel/built-in.a"
	@echo "│       ├── mm/built-in.a"
	@echo "│       ├── fs/built-in.a"
	@echo "│       ├── drivers/built-in.a"
	@echo "│       ├── net/built-in.a"
	@echo "│       └── arch/x86/built-in.a"
	@echo "└── arch/x86/boot/bzImage"
	@echo "    ├── setup.bin"
	@echo "    │   ├── arch/x86/boot/setup.o"
	@echo "    │   └── arch/x86/boot/video.o"
	@echo "    └── vmlinux.bin"
	@echo "        ├── arch/x86/boot/compressed/head_64.o"
	@echo "        ├── arch/x86/boot/compressed/misc.o"
	@echo "        ├── arch/x86/boot/compressed/string.o"
	@echo "        └── arch/x86/boot/compressed/vmlinux"
	@echo "            └── vmlinux → head_64.S"
	@echo ""
	@echo "rootfs.cpio.gz"
	@echo "└── ."
	@echo "    ├── init"
	@echo "    ├── bin"
	@echo "    │   ├── busybox"
	@echo "    │   └── sh"
	@echo "    ├── proc"
	@echo "    ├── sys"
	@echo "    └── dev"

run:	$(BZIMAGE_PATH)	rootfs.cpio.gz

	@echo "Try and get this to work with vanilla linux github repo, not tinycore linux archive"

	qemu-system-x86_64 \
		-kernel /Volumes/trash/trash/linux-6.12.11/arch/x86/boot/bzImage \
		-initrd rootfs.cpio.gz \
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
		-v /Volumes/trash/trash:/out	\
		$(DOCKER_IMAGE)

