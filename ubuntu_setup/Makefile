# common logic
MYVALUE=world

# % is a wilcard

# by default, make builds the first target
all:	clear	external
	echo "Building" $(MYVALUE)

help:
	echo "make -f ubuntu_setup/Makefile"

external:
	cp /Users/sarnobat/computers.git/docker/.zshrc .

clear:
	sudo docker rm --force $(sudo docker ps --all --quiet)	2>/dev/null || echo "no existing container to delete"
	sudo docker image rm --force $(sudo docker images --quiet)	2>/dev/null || echo "no existing image to delete"
	echo "Cleared"

	# verify we have a clean slate	
	sudo docker images

# 	rm .aliases

