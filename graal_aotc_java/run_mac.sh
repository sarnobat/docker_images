## IDEMPOTENT

set -e
#set -o pipefail

cat <<EOF
/Applications/Docker.app/Contents/MacOS/Docker
or
/Applications/Docker.app/Contents/MacOS/com.docker.backend -watchdog -native-api
EOF

# Get them from inside the mounted computers.git
rm .zshrc
rm .aliases
#cp -v ~/computers.git/docker/.zshrc .
#cp -v ~/.aliases .


sudo docker rm --force $(sudo docker ps --all --quiet) || echo "no existing container to delete"
sudo docker image rm --force $(sudo docker images --quiet) || echo "no existing image to delete"
sudo docker images
sudo docker build --label mylabel --tag mytag .
sudo docker images
# sudo docker run --name mycontainer intro/v1
sudo docker run  --volume /Volumes/git/github/docker_images/graal_aotc_java.2024/:/root/proj --volume /Volumes/git/:/media/sarnobat/git --name mycontainer --detach --tty --interactive mytag sh
sudo docker exec -u root -it mycontainer sh
sudo docker exec -u root -it mycontainer /root/proj/gradlew build
sudo docker exec -u root -it mycontainer java -jar /root/proj/build/libs/graal_aotc_java-1.0.jar
sudo docker stop mycontainer
sudo docker rm mycontainer
#sudo docker image rm myimage
sudo docker ps --all
