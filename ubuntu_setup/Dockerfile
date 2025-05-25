#FROM alpine
FROM ubuntu:22.04

# COPY helloworld.go /
#COPY helloworld.py /


# This will make apt use default answers for interactive questions
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
# I think zsh is deleting /root/.zshrc on initial launch so it's not there.
# Using ZDOTDIR works, even though I don't like it
ENV ZDOTDIR=/tmp/
COPY .zshrc /tmp/.zshrc

# ADD .zshrc .zshrc
RUN apt update
# RUN apt install -y golang

RUN apt install -y autossh
RUN apt install -y bat
RUN apt install -y bzip2
RUN apt install -y git
RUN apt install -y grc
RUN apt install -y inetutils-ping
iproute2
RUN apt install -y lsof
RUN apt install -y net-tools
RUN apt install -y nmap
RUN apt install -y openssh-server
RUN apt install -y plocate
RUN apt install -y psmisc # pstree
RUN apt install -y sudo
RUN apt install -y vim
RUN apt install -y wget
RUN apt install -y zsh

# RUN ln -sr /media/sarnobat/git/computers.git /home/sarnobat/
# RUN ln -sr /media/sarnobat/git/computers.git/docker/.zshrc ~/
#RUN apt install -y plocate
# pstree
#RUN apt install -y psmisc
RUN ln -sr /media/sarnobat/git/computers.git ~/computers.git
RUN cd /root/ && ln -sr /media/sarnobat/git/computers.git/2022/docker/.zshrc
RUN ln -sr /media/sarnobat/git/computers.git/dotfiles_and_scripts/.dir_colors ~/
RUN ln -sr /media/sarnobat/git/computers.git/mac/git/mac/.gitconfig ~/
RUN ln -srf /media/sarnobat/git/computers.git ~/

# This gets erased if in root, though it works for non-root
#COPY .zshrc /root/

# RUN service ssh start
RUN useradd -rm -d /home/sarnobat -s /bin/bash -g root -G sudo -u 1000 sarnobat
RUN echo 'sarnobat	ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN  echo 'sarnobat:sarnobat' | chpasswd
RUN ssh-keygen -A
RUN service ssh start
# RUN useradd -m -s /bin/zsh sarnobat
# USER sarnobat

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

COPY .zshrc /home/sarnobat/



USER sarnobat

RUN ln -sr /media/sarnobat/git/computers.git ~/
RUN ln -sr /media/sarnobat/git/github ~/
# RUN chsh /usr/bin/zsh

# I think I need to install gnome first
# RUN gsettings set org.gnome.desktop.session idle-delay 0
# .gitconfig

# CMD [ "source /root/.zshrc", "zsh"]
# CMD ["/bin/zsh"]
# CMD ["-f","/dev/null"]
# CMD ["go", "run","helloworld.go"]
# ENTRYPOINT ["source", ".zshrc"]

# Mounting via Dockerfile
# This simply cannot be done. Docker images are designed to be portable. Host mounts are host specific. Thus if you are able to specify a host mount at build time, it will make the image non-portable across machine that don't have this mount folder. Thus this is why this option is not available.
# You can use docker compose to help the user not choose the mount folder. 
