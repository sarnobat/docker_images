## IDEMPOTENT

# set -o pipefail

trap 'script did not finish. Want to print anything here?' ERR

cat <<EOF
/Applications/Docker.app/Contents/MacOS/Docker
or
/Applications/Docker.app/Contents/MacOS/com.docker.backend -watchdog -native-api
EOF

# Get them from inside the mounted computers.git
# rm .zshrc
rm .aliases

set -e
cp /Users/sarnobat/computers.git/docker/.zshrc .

rsync -a -v /Users/sarnobat/Desktop/2025-01_harvard_compilers/e95-src.git .

sudo docker rm --force $(sudo docker ps --all --quiet) || echo "no existing container to delete"
sudo docker image rm --force $(sudo docker images --quiet) || echo "no existing image to delete"
sudo docker images
sudo docker build  --progress=plain --label mylabel --tag mytag .
sudo docker images
# sudo docker run --name mycontainer intro/v1
sudo docker run --volume /Volumes/git/:/media/sarnobat/git --name mycontainer --detach --tty --interactive mytag zsh 
sudo docker exec -u sarnobat -it mycontainer zsh
sudo docker stop mycontainer
sudo docker rm mycontainer
#sudo docker image rm myimage
sudo docker ps --all
sh /Volumes/git/computers.git/mac/bin/docker_prune_images.sh