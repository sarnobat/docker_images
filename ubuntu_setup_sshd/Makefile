# Common variables
DOCKER = sudo docker
TAG = mytag
LABEL = mylabel
CONTAINER = mycontainer
MOUNT_SRC = /Volumes/git/
MOUNT_DST = /media/sarnobat/git
ZSHRC_SRC = /Users/sarnobat/computers.git/docker/.zshrc
PRUNE_SCRIPT = /Volumes/git/computers.git/mac/bin/docker_prune_images.sh

all:	build	run
	@echo "Now do this:"
	@echo ""
	@echo "	make test"
	@echo ""

build:
	cp $(ZSHRC_SRC) .
	$(DOCKER) rm --force $$($(DOCKER) ps --all --quiet) || echo "no existing container to delete"
	$(DOCKER) image rm --force $$($(DOCKER) images --quiet) || echo "no existing image to delete"
	$(DOCKER) images
	$(DOCKER) build --progress=plain --label $(LABEL) --tag $(TAG) .
	$(DOCKER) images

run:
	$(DOCKER) rm $(CONTAINER) || echo ""
	$(DOCKER) run -p 2244:22 --volume $(MOUNT_SRC):$(MOUNT_DST) --name $(CONTAINER) --detach --tty $(TAG)
	# /lib/modules/ won't exist in a container unfortunately. So I can't make sense of a linux kernel using containers.
	# 1GB
# 	$(DOCKER) exec -u sarnobat -it $(CONTAINER) apt install -y linux-image-unsigned-6.8.0-87-generic-dbgsym
	$(DOCKER) exec -u sarnobat -it $(CONTAINER) zsh
	$(DOCKER) stop $(CONTAINER)
	$(DOCKER) rm $(CONTAINER)
	#$(DOCKER) image rm $(TAG)
	$(DOCKER) ps --all
	sh $(PRUNE_SCRIPT)

exec:
	$(DOCKER) ps
# 	$(DOCKER) exec -u sarnobat -it $(CONTAINER) tail -f /tmp/sshd.log
	$(DOCKER) exec -u sarnobat -it $(CONTAINER) zsh
	
test:
	sshpass -p 'sarnobat' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2244 sarnobat@localhost 
	#ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2244 sarnobat@localhost

# Note:
# 'apt install linux-image-arm64-dbg' provides debug (.ko) files.
# You can use 'nm' on those to inspect where kernel components (memory, network, FS) are defined.
