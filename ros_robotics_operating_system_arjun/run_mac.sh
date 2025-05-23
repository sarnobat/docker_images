## IDEMPOTENT

#set -o pipefail

# cat <<EOF
# /Applications/Docker.app/Contents/MacOS/Docker
# or
# /Applications/Docker.app/Contents/MacOS/com.docker.backend -watchdog -native-api
# EOF
sh /Volumes/git/computers.git/mac/bin/docker_prune_images.sh
cat <<EOF
Warning: you'll get this error:

	root@e851f886a854:/opt/ros# source setup.bash
	[rti_connext_dds_cmake_module][warning] No RTI Connext DDS installation specified.. RTI Connext DDS will not be available at runtime,unless you already configured LD_LIBRARY_PATH manually.

EOF

read -p "Are you sure (y/N)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    echo ""
else
	exit
fi

# Get them from inside the mounted computers.git
# rm .zshrc
# rm .aliases
set -e
cp /Users/sarnobat/computers.git/docker/.zshrc .
cp ~/.ssh/google_compute_engine .
rsync -a -v --progress /Volumes/new/ros2-kilted-beta2-20250507-linux-noble-amd64.tar.bz2 .
#cp -v ~/computers.git/docker/.zshrc .
#cp -v ~/.aliases .


sudo docker rm --force $(sudo docker ps --all --quiet) || echo "no existing container to delete"
sudo docker image rm --force $(sudo docker images --quiet) || echo "no existing image to delete"
sudo docker images
sudo docker build --progress=plain  --label mylabel --tag mytag .
sudo docker images
# delete what we don't want to source control
rm google_compute_engine
rm ros2-kilted-beta2-20250507-linux-noble-amd64.tar.bz2
# sudo docker run --name mycontainer intro/v1
sudo docker run --volume /Volumes/git/:/media/sarnobat/git --name mycontainer --detach --tty --interactive mytag zsh 
# sudo docker exec -u root -it mycontainer zsh
sudo docker exec -u rosuser -it mycontainer zsh
# sudo docker exec -u rosuser -it mycontainer zsh
sudo docker stop mycontainer
sudo docker rm mycontainer
#sudo docker image rm myimage
sudo docker ps --all
sh /Volumes/git/computers.git/mac/bin/docker_prune_images.sh