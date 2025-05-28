# common logic
MYVALUE=world

# by default, make builds the first target
all:	clear	external
	echo "Building" $(MYVALUE)

help:
	@cat <<EOF
	Tips
	----
EOF
	echo "make -f ubuntu_setup/Makefile"

external:
	cp /Users/sarnobat/computers.git/docker/.zshrc .

clear:
	sudo docker rm --force $(sudo docker ps --all --quiet) || echo "no existing container to delete"
	sudo docker image rm --force $(sudo docker images --quiet) || echo "no existing image to delete"
	echo "Cleared"
# 	rm .aliases

