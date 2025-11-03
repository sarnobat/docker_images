## IDEMPOTENT

# set -o pipefail

#trap 'script did not finish. Want to print anything here?' ERR
trap 'echo dirty end (local) ' SIGINT
trap 'echo dirty end (pipe)  ' SIGPIPE

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

#cp -v ~/computers.git/docker/.zshrc .
#cp -v ~/.aliases .


sudo docker rm --force $(sudo docker ps --all --quiet) || echo "no existing container to delete"
sudo docker image rm --force $(sudo docker images --quiet) || echo "no existing image to delete"
sudo docker images
sudo docker build  --progress=plain --label mylabel --tag mytag .
sudo docker images
# sudo docker run --name mycontainer intro/v1
# sudo docker run --volume /Volumes/git/:/media/sarnobat/git --name mycontainer --detach --tty --interactive mytag zsh 
sudo docker run -p 2244:22 --volume /Volumes/git/:/media/sarnobat/git --name mycontainer --detach --tty mytag 
sudo docker exec -u sarnobat -it mycontainer zsh
sudo docker stop mycontainer
sudo docker rm mycontainer
#sudo docker image rm myimage
sudo docker ps --all
sh /Volumes/git/computers.git/mac/bin/docker_prune_images.sh
