#FROM alpine
FROM ubuntu:22.04
CMD ["echo", "Hello StackOverflow!"]


# COPY helloworld.go /
#COPY helloworld.py /

# This will make apt use default answers for interactive questions
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
# ADD .zshrc .zshrc
RUN apt update

# RUN apt install -y golang

RUN apt install -y autossh
RUN apt install -y bat
RUN apt install -y git
RUN apt install -y grc
RUN apt install -y inetutils-ping
RUN apt install -y lsof
RUN apt install -y nmap
RUN apt install -y openssh-server
RUN apt install -y plocate
RUN apt install -y psmisc # pstree
RUN apt install -y sudo
RUN apt install -y vim
RUN apt install -y zsh

# RUN ln -sr /media/sarnobat/git/computers.git ~/
# RUN ln -sr /media/sarnobat/git/computers.git/docker/.zshrc ~/


RUN ln -sr /media/sarnobat/git/computers.git ~/computers.git
RUN cd /root/ && ln -sr /media/sarnobat/git/computers.git/2022/docker/.zshrc
RUN ln -sr /media/sarnobat/git/computers.git/dotfiles_and_scripts/.dir_colors ~/
RUN ln -sr /media/sarnobat/git/computers.git/mac/git/mac/.gitconfig ~/

COPY .zshrc /root/
COPY .zshrc /tmp/

# RUN service ssh start
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 
RUN  echo 'test:test' | chpasswd
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd", "-d","-D"]

RUN apt update && apt install -y curl gnupg2 lsb-release
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
# CMD apt update
# CMD apt install -y ros2


RUN apt install -y bzip2
# RUN find ./
# RUN apt update 
# USER root
RUN apt install -y python3-rosdep2 
RUN rm /etc/ros/rosdep/sources.list.d/20-default.list
RUN useradd -m -s /bin/zsh rosuser
# RUN useradd -rm -d /home/rosuser -s /bin/bash -g root -G sudo -u 1000 sarnobat
RUN echo 'rosuser	ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN  echo 'rosuser:rosuser' | chpasswd

RUN rosdep init 
USER rosuser
ENV SHELL=/bin/zsh
RUN rosdep update

USER root
# RUN ln -s /media/sarnobat/git/computers.git ~/

# COPY .zshrc /root/
COPY .zshrc /home/rosuser/
RUN touch /root/.zshrc
RUN apt install -y libpython3-dev python3-pip
RUN pip3 install -U argcomplete
ENV SHELL=/bin/zsh
RUN rosdep fix-permissions
USER rosuser
RUN rosdep update 
USER rosuser
RUN mkdir /home/rosuser/.ssh/
# RUN mkdir -p ~/ros2_dashing && cd ~/ros2_dashing && wget 'https://github.com/ros2/ros2/releases/download/release-kilted-beta2-20250507/ros2-kilted-beta2-20250507-linux-noble-amd64.tar.bz2' && tar -xvf ros2-kilted-beta2-20250507-linux-noble-amd64.tar.bz2


# RUN mkdir -p ~/ros2_dashing/
# RUN mkdir -p /opt/
# COPY ros2-kilted-beta2-20250507-linux-noble-amd64.tar.bz2 /home/rosuser/ros2_dashing/
# RUN cd /home/rosuser/ros2_dashing/ && tar -xvf ros2-kilted-beta2-20250507-linux-noble-amd64.tar.bz2



USER root
COPY ros2-kilted-beta2-20250507-linux-noble-amd64.tar.bz2 /tmp/


#####################
### Works but let's see if we  can do it with apt
#####################
##RUN cd /opt/ && tar -xvf /tmp/ros2-kilted-beta2-20250507-linux-noble-amd64.tar.bz2
##RUN cd /opt/ && mv -v ros2-linux ros

RUN ln -s /home/rosuser/ros2_dashing /root/
RUN ln -s /opt/ros
RUN touch /home/rosuser/.zshrc

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0yle+37BF9uQ+/IoQwpbErXAbXbakBTpap+KrtIEa2yFBRRE+A5lLOztz4mQj5KySygKYVtyE0TS3sLvPgBpl/1J2ej/NTRozQ6jRBMhV/k/cT6/8P/SjnaSPVEtfUPSSFqnP+JN5YUiylJ/sTmIZIjYDJ87QO/xAMfKnZWbVvM+EqvZPPmayVJvX79clC+CasTRs3h5I7ZNDHQ4y/truHgWMGEclm8bbvg+4vsVPRGSffFidUIJpJ4ZSQ3PnW5MvquHn4wyDx79dbFesrDj13HLiHb64hE5n3jgpPYWX/WNbifcduBtMRNyyTGbRIU6xfLSdYh9jg4yhOn1YIjyv6q6B9ijmYKn9LxHCt7jAE6yArmZW5XraAwpwDJm3ZQs6t4ISoTjW5xsALttBTSZ0yfhG/9NqzG5gkkOvq2jX5TqpguBp6CPN7wQEcZgMekGqh4NUBVn/s7GB7VV0V24U7DrrQ84rUTZDneVEH4It39fzE0ztGfB2x5qFtKdOKMk= ros@ros-QEMU-Virtual-Machine" > /home/rosuser/.ssh/id_rsa.pub
COPY google_compute_engine /home/rosuser/.ssh/
RUN chmod 600 /home/rosuser/.ssh/*
RUN chown rosuser /home/rosuser/.ssh/*

USER rosuser
RUN echo "now run (TODO: this doesn't work automatically):\nautossh -M0 -N -i ~/.ssh/google_compute_engine -R 3334:localhost:22 -o 'StrictHostKeyChecking no' sarnobat@34.69.137.166"
CMD autossh -M0 -i ~/.ssh/google_compute_engine -R 3334:localhost:22 -o "StrictHostKeyChecking no" sarnobat@34.69.137.166


USER rosuser
RUN sudo ssh-keygen -A
# USER root
RUN sudo service ssh start

EXPOSE 22
CMD ["/usr/sbin/sshd", "-d","-D"]

# WORKDIR /home/rosuser/ros2_dashing/
# RUN rosdep install --from-paths ~/ros2_dashing/ros2-linux/share --ignore-src --rosdistro kilted -y --skip-keys "console_bridge fastcdr fastrtps libopensplice67 libopensplice69 osrf_testing_tools_cpp poco_vendor rmw_connext_cpp rosidl_typesupport_connext_c rosidl_typesupport_connext_cpp rti-connext-dds-5.3.1 tinyxml_vendor tinyxml2_vendor urdfdom urdfdom_headers"
#RUN source /home/rosuser/.zshrc

# .gitconfig

# CMD [ "source /root/.zshrc", "zsh"]
# CMD ["/bin/zsh"]
# CMD ["-f","/dev/null"]
# CMD ["go", "run","helloworld.go"]
# ENTRYPOINT ["source", ".zshrc"]

# Mounting via Dockerfile
# This simply cannot be done. Docker images are designed to be portable. Host mounts are host specific. Thus if you are able to specify a host mount at build time, it will make the image non-portable across machine that don't have this mount folder. Thus this is why this option is not available.
# You can use docker compose to help the user not choose the mount folder. 
