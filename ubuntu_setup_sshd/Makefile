# Common variables
DOCKER = sudo docker
TAG = mytag
LABEL = mylabel
CONTAINER = mycontainer
MOUNT_SRC = /Volumes/git/
MOUNT_DST = /media/sarnobat/git
ZSHRC_SRC = /Users/sarnobat/computers.git/docker/.zshrc
PRUNE_SCRIPT = /Volumes/git/computers.git/mac/bin/docker_prune_images.sh

build:
	cp $(ZSHRC_SRC) .
	$(DOCKER) rm --force $$($(DOCKER) ps --all --quiet) || echo "no existing container to delete"
	$(DOCKER) image rm --force $$($(DOCKER) images --quiet) || echo "no existing image to delete"
	$(DOCKER) images
	$(DOCKER) build --progress=plain --label $(LABEL) --tag $(TAG) .
	$(DOCKER) images

run:
	$(DOCKER) run -p 2244:22 --volume $(MOUNT_SRC):$(MOUNT_DST) --name $(CONTAINER) --detach --tty $(TAG)
	$(DOCKER) exec -u sarnobat -it $(CONTAINER) zsh
	$(DOCKER) stop $(CONTAINER)
	$(DOCKER) rm $(CONTAINER)
	#$(DOCKER) image rm $(TAG)
	$(DOCKER) ps --all
	sh $(PRUNE_SCRIPT)

# Note:
# 'apt install linux-image-arm64-dbg' provides debug (.ko) files.
# You can use 'nm' on those to inspect where kernel components (memory, network, FS) are defined.
