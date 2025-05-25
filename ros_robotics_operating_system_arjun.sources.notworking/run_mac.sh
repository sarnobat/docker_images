sh /Volumes/git/computers.git/mac/bin/docker_prune_images.sh

set -e
cp /Users/sarnobat/computers.git/docker/.zshrc .

sudo docker rm --force $(sudo docker ps --all --quiet) || echo "no existing container to delete"
sudo docker image rm --force $(sudo docker images --quiet) || echo "no existing image to delete"
sudo docker images

sudo docker build --progress=plain  --label mylabel --tag mytag .
sudo docker images
sudo docker run --volume /Volumes/git/:/media/sarnobat/git --name mycontainer --detach --tty mytag
sudo docker exec -u ros -it mycontainer zsh

echo "stopping"
sudo docker stop mycontainer
sudo docker rm mycontainer
sudo docker ps --all
sh /Volumes/git/computers.git/mac/bin/docker_prune_images.sh