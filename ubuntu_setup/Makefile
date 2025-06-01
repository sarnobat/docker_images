# common logic
MYVALUE=world

# % is a wilcard

# by default, make builds the first target
all:	clean	external	build	run
	echo "Building" $(MYVALUE)

build:
	sudo docker build  --progress=plain --label mylabel --tag mytag .
	sudo docker run --volume /Volumes/git/:/media/sarnobat/git --name mycontainer --detach --tty --interactive mytag zsh 

run:
	sudo docker exec -u sarnobat -it mycontainer zsh

help:
	echo "make -f ubuntu_setup/Makefile"

view:
	sudo docker ps --all
	sudo docker images

external:
	cp /Users/sarnobat/computers.git/docker/.zshrc .

clean:

# 	test -f .zshrc && rm .zshrc
	
	sudo docker stop mycontainer
	sudo docker rm mycontainer

	sudo docker rm --force $(sudo docker ps --all --quiet)	2>/dev/null || echo "no existing container to delete"
	sudo docker image rm --force $(sudo docker images --quiet)	2>/dev/null || echo "no existing image to delete"
# 	echo "Cleared"

	# verify we have a clean slate	
# 	sudo docker images


	docker ps
# 	rm .aliases

