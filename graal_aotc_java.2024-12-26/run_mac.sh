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
sudo docker build --label mylabel --tag mytag .
sudo docker images
# sudo docker run --name mycontainer intro/v1
sudo docker run --volume /Volumes/git/github/docker_images/graal_aotc_java.2024:/root/proj --name mycontainer_graalvm --detach --tty --interactive mytag
docker cp mycontainer_graalvm:/proj/build/native/nativeCompile/graal_aotc_java /tmp/helloworld
#  sh
# sudo docker exec -u root -it mycontainer_graalvm sh
sudo docker stop mycontainer_graalvm
sudo docker rm mycontainer_graalvm
#sudo docker image rm myimage
sudo docker ps --all
cat <<EOF
Unfortunately, the native image is only for linux.GraalVM will probably never support cross-compile. You need a MacOS docker base (which is hard to include with GraalVM and Gradle).
Golang or Github Workflow is the only way solution.
EOF