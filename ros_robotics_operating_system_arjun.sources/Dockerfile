FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
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

COPY .zshrc /root/
COPY .zshrc /tmp/

RUN useradd -m -s /bin/zsh ros
RUN echo 'ros	ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN  echo 'ros:ros' | chpasswd

COPY .zshrc /home/ros/.zshrc
RUN touch /home/ros/.zshrc

USER ros
ENV SHELL=/bin/zsh

RUN locale	\
	&& sudo apt update && sudo apt install locales \
	&& sudo locale-gen en_US en_US.UTF-8	\
	&& sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8	\
	&& export LANG=en_US.UTF-8	\	
	&& locale	\
	&& sudo apt install -y software-properties-common	\
	&& sudo add-apt-repository universe	\
	&& sudo apt update && sudo apt install curl -y	\
	&& sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg	\
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null	\
	&& sudo apt update && sudo apt install -y \
		python3-flake8-docstrings \
	&& echo ""
# 		python3-pip \
# 		python3-pytest-cov \
# 		ros-dev-tools	\
# 	&& sudo apt installs -y \
# 		python3-flake8-blind-except \
# 		python3-flake8-builtins \
# 		python3-flake8-class-newline \
# 		python3-flake8-comprehensions \
# 		python3-flake8-deprecated \
# 		python3-flake8-import-order \
# 		python3-flake8-quotes \
# 		python3-pytest-repeat \
# 		python3-pytest-rerunfailures	\
# 	&& mkdir -p ~/ros2_humble/src	\
# 	&& cd ~/ros2_humble	\
# 	&& vcs import --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src	\
# 	&& sudo apt upgrade
	
# 	&& sudo rosdep init	\
# 	&& rosdep update	\
# 	&& rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers"	\
# 	&& cd ~/ros2_humble/	\
# 	&& colcon build --symlink-install