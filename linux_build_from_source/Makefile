DOCKER_IMAGE := rootfs-builder
DOCKERFILE   := Dockerfile_rootfs

# build:	/Volumes/git/github/linux/arch/x86/boot/bzImage

# /Volumes/git/github/linux/arch/x86/boot/bzImage:
bzImage:
# 	cd /Volumes/git/github/ && ln -sf linux linux-6.12.11
	docker build -t tinycore-kernel-builder .	\
		&& docker rm -f kerneldebug 2>/dev/null || true	\
		&& docker run --name kerneldebug	\
			-v /Volumes/git/github/:/out	\
			tinycore-kernel-builder		\
			make -f /build/Makefile_linux
	@echo "See here for code locations (keeping my log statements is tough with such a big codebase) https://github.com/sarnobat/linux_kernel/blob/master/README.md#2025"

rebuild:
	docker build -t tinycore-kernel-builder .	\
			&& docker rm -f kerneldebug 2>/dev/null || true	\
			&& docker run --name kerneldebug	\
				-v /Volumes/git/github/:/out	\
				tinycore-kernel-builder		\
				make -f /build/Makefile_linux rebuild

checkout:
	# * adc218676eef 2024-11-17 Linux 6.12  Linus Torvalds  (HEAD -> v6.12, tag: v6.12)
	cd /Volumes/git/github/linux/ && git checkout v6.12

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
	@echo ""
	@echo "print statement with colors"
	@echo 'pr_info("\\033[38;5;45m[trace]\\033[0m " \
        "\\033[38;5;202mSRIDHAR\\033[0m Run %s as init process\n", \
        init_filename);'
	@echo "\nThis entire build job is better than the tinycore one but still nto completely touchless due to the nature of downloading the source code. "

run:	/Volumes/git/github/linux/arch/x86/boot/bzImage	rootfs.cpio.gz

	@echo "Try and get this to work with vanilla linux github repo, not tinycore linux archive"

	qemu-system-x86_64 \
		-kernel /Volumes/git/github/linux/arch/x86/boot/bzImage \
		-initrd rootfs.cpio.gz \
		-m 512 \
		-nographic \
		-device virtio-net-pci,netdev=n0 \
		-netdev user,id=n0 \
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

