## IDEMPOTENT

set -e
#set -o pipefail

cat <<EOF
First time setup
-----------------
so you don't have to use sudo
EOF

cat <<EOF > /tmp/docker_config.sh
sudo usermod -a -G docker sarnobat
newgrp docker
EOF
batcat --plain --paging=never --language sh --theme TwoDark /tmp/docker_config.sh

cat <<EOF
Image building
--------------
EOF
sudo docker rm --force $(sudo docker ps --all --quiet) || echo "no existing container to delete"
sudo docker image rm --force $(sudo docker images --quiet) || echo "no existing image to delete"
sudo docker images
sudo docker build --label mylabel --tag mytag .
sudo docker images

cat <<EOF
Container creation & running
----------------------------
EOF

# sudo docker run --name mycontainer intro/v1
sudo docker run --volume /home/sarnobat/computers.git:/home/root/computers.git -p 2211:22 --name mycontainer --detach --tty --interactive mytag zsh 
docker exec -u root -it mycontainer zsh
cat <<EOF
Cleanup
-------
EOF
cat <<EOF > /tmp/docker_cleanup.sh
sudo docker stop mycontainer
sudo docker rm mycontainer
#sudo docker image rm myimage
sudo docker ps --all

EOF

cat <<EOF
sh -x /tmp/docker_cleanup.sh
EOF


batcat --plain --paging=never --language sh --theme TwoDark /tmp/docker_cleanup.sh
sh -x /tmp/docker_cleanup.sh