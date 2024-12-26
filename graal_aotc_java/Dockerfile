#FROM alpine
FROM ubuntu:22.04
CMD ["echo", "Hello StackOverflow!"]


# COPY helloworld.go /
#COPY helloworld.py /

# This will make apt use default answers for interactive questions
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/zsh
# ADD .zshrc .zshrc
RUN apt update
# RUN apt install -y golang
RUN apt install -y zsh
RUN apt install -y lsof
RUN apt install -y git
RUN apt install -y bat
RUN apt install -y grc
RUN apt install -y vim
RUN apt install -y openssh-server
RUN apt install -y nmap
RUN apt install -y inetutils-ping
RUN apt install -y plocate
# pstree
RUN apt install -y psmisc
RUN ln -sr /home/root/computers.git ~/computers.git
RUN ln -sr /home/root/computers.git/docker/.zshrc ~/
RUN ln -sr /home/root/computers.git/dotfiles_and_scripts/.dir_colors ~/
RUN ln -sr /home/root/computers.git/mac/git/mac/.gitconfig ~/
