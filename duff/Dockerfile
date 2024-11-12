#FROM alpine
FROM ubuntu:14.04.2
CMD ["echo", "Hello StackOverflow!"]


# COPY helloworld.go /
#COPY helloworld.py /

# This will make apt use default answers for interactive questions
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/zsh
# ADD .zshrc .zshrc
RUN apt update
RUN apt install -y zsh
RUN apt install -y git
RUN apt install -y openssh-server
RUN apt install -y nmap
RUN apt install -y inetutils-ping
# RUN ln -sr /media/sarnobat/git/computers.git ~/
# RUN ln -sr /media/sarnobat/git/computers.git/docker/.zshrc ~/
# pstree
RUN apt install -y psmisc
RUN ln -sr /home/root/computers.git ~/computers.git
RUN ln -sr /home/root/computers.git/docker/.zshrc ~/
RUN ln -sr /home/root/computers.git/dotfiles_and_scripts/.dir_colors ~/
RUN ln -sr /home/root/computers.git/mac/git/mac/.gitconfig ~/

# RUN service ssh start
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 
RUN  echo 'test:test' | chpasswd
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

RUN git clone https://github.com/elmindreda/duff.git

# .gitconfig

# CMD [ "source /root/.zshrc", "zsh"]
# CMD ["/bin/zsh"]
# CMD ["-f","/dev/null"]
# CMD ["go", "run","helloworld.go"]
# ENTRYPOINT ["source", ".zshrc"]

# Mounting via Dockerfile
# This simply cannot be done. Docker images are designed to be portable. Host mounts are host specific. Thus if you are able to specify a host mount at build time, it will make the image non-portable across machine that don't have this mount folder. Thus this is why this option is not available.
# You can use docker compose to help the user not choose the mount folder. 
