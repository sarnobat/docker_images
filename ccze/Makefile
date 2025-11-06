build:
	sudo docker rm --force $(sudo docker ps --all --quiet) || echo "no existing container to delete"
	sudo docker image rm --force $(sudo docker images --quiet) || echo "no existing image to delete"
	sudo docker images
	sudo docker build --label mylabel --tag mytag .
	sudo docker images

run:	clean
	echo "cat INSTALL | /usr/local/bin/ccze"
# 	sudo docker rm mycontainer || echo ""
# 	sudo docker run  --name mycontainer mytag sh 
	sudo docker run -dt  --name mycontainer mytag sh
	
	sudo docker exec -u root -it mycontainer   sh -c "find /"
# 	sudo docker exec -u root -it mycontainer   sh -c "cat INSTALL | /usr/local/bin/ccze"
	echo "tail -100f INSTALL | /usr/local/bin/ccze"
	sudo docker exec -u root -it mycontainer zsh
# 	sudo docker run  --name mycontainer --tty --interactive mytag sh

clean:
	sudo docker stop mycontainer || echo
	sudo docker rm mycontainer || echo
	#sudo docker image rm myimage
	sudo docker ps --all	