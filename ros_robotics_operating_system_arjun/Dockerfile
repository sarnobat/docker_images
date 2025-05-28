FROM ubuntu:jammy


ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
RUN apt update

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

COPY .zshrc /root/
COPY .zshrc /tmp/

# Set the locale
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8

# Set the timezone
ENV ROS_VERSION=2
ENV ROS_DISTRO=humble
ENV ROS_PYTHON_VERSION=3
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setup the sources
RUN apt-get update && apt-get install -y software-properties-common curl && \
    add-apt-repository universe && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS 2 packages
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
	ros-humble-desktop-full ros-humble-ros2run ros-humble-simulation	ros-humble-teleop-twist-keyboard


# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    nano \
    iputils-ping \
    wget \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro humble

# Environment setup
RUN echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
RUN echo '#!/usr/bin/env bash' > /ros_entrypoint.sh
RUN echo 'source /opt/ros/humble/setup.bash' >> /ros_entrypoint.sh
RUN echo 'exec "$@"' >> /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh


RUN useradd -m -s /bin/zsh ros
RUN echo 'ros	ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN  echo 'ros:ros' | chpasswd

ENV ZDOTDIR=/tmp/
COPY .zshrc /tmp/.zshrc


# ENTRYPOINT ["/ros_entrypoint.sh"]


# RUN locale	\
# 	&& sudo apt update && sudo apt install locales \
# 	&& sudo locale-gen en_US en_US.UTF-8	\
# 	&& sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8	\
# 	&& export LANG=en_US.UTF-8	\	
# 	&& locale	\
# 	&& sudo apt install -y software-properties-common	\
# 	&& sudo add-apt-repository universe	\
# 	&& sudo apt update && sudo apt install curl -y	\
# 	&& sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg	\
# 	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null	\
# 	&& echo ""
# RUN apt install -y bzip2
# 
# RUN apt install -y python3-rosdep2 
# RUN rm /etc/ros/rosdep/sources.list.d/20-default.list
# RUN useradd -m -s /bin/zsh ros
# RUN echo 'ros	ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
# RUN  echo 'ros:ros' | chpasswd
# 
# RUN apt update -y
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt upgrade
# RUN sudo apt install -y ros-humble-ros-base
# RUN sudo apt install -y ros-humble-desktop
# RUN sudo apt install -y ros-humble-desktop-full
# RUN sudo apt install -y ros-humble-ros2run
# 		ros-humble-simulation	ros-humble-teleop-twist-keyboard

# RUN rosdep init 
# USER ros
# ENV SHELL=/bin/zsh
# RUN rosdep update
# 
# 
# 
# 
# USER root
# 
# COPY .zshrc /home/ros/
# RUN touch /root/.zshrc
# RUN apt install -y libpython3-dev python3-pip
# RUN pip3 install -U argcomplete
# ENV SHELL=/bin/zsh
# RUN rosdep fix-permissions
# USER ros
# RUN rosdep update 
# USER ros
# RUN mkdir /home/ros/.ssh/

# RUN ln -s /home/ros/ros2_dashing /root/
# RUN ln -s /opt/ros
# RUN touch /home/ros/.zshrc
# 
# RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0yle+37BF9uQ+/IoQwpbErXAbXbakBTpap+KrtIEa2yFBRRE+A5lLOztz4mQj5KySygKYVtyE0TS3sLvPgBpl/1J2ej/NTRozQ6jRBMhV/k/cT6/8P/SjnaSPVEtfUPSSFqnP+JN5YUiylJ/sTmIZIjYDJ87QO/xAMfKnZWbVvM+EqvZPPmayVJvX79clC+CasTRs3h5I7ZNDHQ4y/truHgWMGEclm8bbvg+4vsVPRGSffFidUIJpJ4ZSQ3PnW5MvquHn4wyDx79dbFesrDj13HLiHb64hE5n3jgpPYWX/WNbifcduBtMRNyyTGbRIU6xfLSdYh9jg4yhOn1YIjyv6q6B9ijmYKn9LxHCt7jAE6yArmZW5XraAwpwDJm3ZQs6t4ISoTjW5xsALttBTSZ0yfhG/9NqzG5gkkOvq2jX5TqpguBp6CPN7wQEcZgMekGqh4NUBVn/s7GB7VV0V24U7DrrQ84rUTZDneVEH4It39fzE0ztGfB2x5qFtKdOKMk= ros@ros-QEMU-Virtual-Machine" > /home/ros/.ssh/id_rsa.pub
# COPY google_compute_engine /home/ros/.ssh/
# RUN chmod 600 /home/ros/.ssh/*
# RUN chown ros /home/ros/.ssh/*
# 
# USER ros
# RUN echo "now run (TODO: this doesn't work automatically):\nautossh -M0 -N -i ~/.ssh/google_compute_engine -R 3334:localhost:22 -o 'StrictHostKeyChecking no' sarnobat@34.69.137.166"
# CMD autossh -M0 -i ~/.ssh/google_compute_engine -R 3334:localhost:22 -o "StrictHostKeyChecking no" sarnobat@34.69.137.166
# 
# 
# USER ros
# RUN sudo ssh-keygen -A
# RUN sudo service ssh start
# 
# EXPOSE 22
# CMD ["/usr/sbin/sshd", "-d","-D"]
