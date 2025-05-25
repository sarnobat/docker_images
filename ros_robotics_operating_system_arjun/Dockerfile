FROM ubuntu:22.04

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

RUN apt update && apt install -y curl gnupg2 lsb-release
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt install -y bzip2

RUN apt install -y python3-rosdep2 
RUN rm /etc/ros/rosdep/sources.list.d/20-default.list
RUN useradd -m -s /bin/zsh ros
RUN echo 'ros	ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN  echo 'ros:ros' | chpasswd

RUN rosdep init 
USER ros
ENV SHELL=/bin/zsh
RUN rosdep update

USER root

COPY .zshrc /home/ros/
RUN touch /root/.zshrc
RUN apt install -y libpython3-dev python3-pip
RUN pip3 install -U argcomplete
ENV SHELL=/bin/zsh
RUN rosdep fix-permissions
USER ros
RUN rosdep update 
USER ros
RUN mkdir /home/ros/.ssh/

RUN ln -s /home/ros/ros2_dashing /root/
RUN ln -s /opt/ros
RUN touch /home/ros/.zshrc

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0yle+37BF9uQ+/IoQwpbErXAbXbakBTpap+KrtIEa2yFBRRE+A5lLOztz4mQj5KySygKYVtyE0TS3sLvPgBpl/1J2ej/NTRozQ6jRBMhV/k/cT6/8P/SjnaSPVEtfUPSSFqnP+JN5YUiylJ/sTmIZIjYDJ87QO/xAMfKnZWbVvM+EqvZPPmayVJvX79clC+CasTRs3h5I7ZNDHQ4y/truHgWMGEclm8bbvg+4vsVPRGSffFidUIJpJ4ZSQ3PnW5MvquHn4wyDx79dbFesrDj13HLiHb64hE5n3jgpPYWX/WNbifcduBtMRNyyTGbRIU6xfLSdYh9jg4yhOn1YIjyv6q6B9ijmYKn9LxHCt7jAE6yArmZW5XraAwpwDJm3ZQs6t4ISoTjW5xsALttBTSZ0yfhG/9NqzG5gkkOvq2jX5TqpguBp6CPN7wQEcZgMekGqh4NUBVn/s7GB7VV0V24U7DrrQ84rUTZDneVEH4It39fzE0ztGfB2x5qFtKdOKMk= ros@ros-QEMU-Virtual-Machine" > /home/ros/.ssh/id_rsa.pub
COPY google_compute_engine /home/ros/.ssh/
RUN chmod 600 /home/ros/.ssh/*
RUN chown ros /home/ros/.ssh/*

USER ros
RUN echo "now run (TODO: this doesn't work automatically):\nautossh -M0 -N -i ~/.ssh/google_compute_engine -R 3334:localhost:22 -o 'StrictHostKeyChecking no' sarnobat@34.69.137.166"
CMD autossh -M0 -i ~/.ssh/google_compute_engine -R 3334:localhost:22 -o "StrictHostKeyChecking no" sarnobat@34.69.137.166


USER ros
RUN sudo ssh-keygen -A
RUN sudo service ssh start

EXPOSE 22
CMD ["/usr/sbin/sshd", "-d","-D"]
