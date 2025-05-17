## IDEMPOTENT

set -e
#set -o pipefail

cat <<EOF
/Applications/Docker.app/Contents/MacOS/Docker
or
/Applications/Docker.app/Contents/MacOS/com.docker.backend -watchdog -native-api
EOF

# Get them from inside the mounted computers.git
# rm .zshrc
# rm .aliases
#cp -v ~/computers.git/docker/.zshrc .
#cp -v ~/.aliases .


sudo docker rm --force $(sudo docker ps --all --quiet) || echo "no existing container to delete"
sudo docker image rm --force $(sudo docker images --quiet) || echo "no existing image to delete"
sudo docker images
sudo docker build --label mylabel --tag mytag --progress=plain .
sudo docker images
# sudo docker run --name mycontainer intro/v1
cat <<EOF > /dev/null
bison file is:
bbedit /Volumes/git/github/2024/docker_images/detox/detox/src/config_file_yacc.y

touch "ubarak-[7249661751770303746].mp4"
/usr/local/bin/detox "ubarak-[7249661751770303746].mp4" && ls ubarak*
EOF
sudo docker run  --name mycontainer --tty --interactive mytag bash
#sudo docker exec -u root -it mycontainer zsh
sudo docker stop mycontainer
sudo docker rm mycontainer
#sudo docker image rm myimage
sudo docker ps --all
