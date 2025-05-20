#FROM alpine
FROM ubuntu:22.04
CMD ["echo", "Hello StackOverflow!"]

COPY detox /proj



RUN apt update

RUN apt install -y autoconf 
RUN apt install -y automake 
RUN apt install -y bison 
RUN apt install -y build-essential
RUN apt install -y flex 
RUN apt install -y gcc
RUN apt install -y gcc 
RUN apt install -y libncurses5-dev
RUN apt install -y libpcre3-dev
RUN apt install -y make 
RUN apt install -y pkg-config
RUN apt install -y wget

RUN apt install -y bat
RUN apt install -y vim
RUN apt install -y zsh
RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess'
RUN wget 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub'
RUN cd /root/ && ln -sr /media/sarnobat/git/computers.git/docker/.zshrc
RUN ln -sr /media/sarnobat/git/computers.git/dotfiles_and_scripts/.dir_colors ~/
RUN ln -sr /media/sarnobat/git/computers.git/mac/git/mac/.gitconfig ~/
RUN ln -sf /media/sarnobat/git/computers.git ~/

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
ENV ZDOTDIR=/tmp/
COPY .zshrc /tmp/.zshrc

# I think zsh is deleting /root/.zshrc on initial launch so it's not there.
# Using ZDOTDIR works, even though I don't like it
RUN touch /root/worked.txt
COPY .zshrc /tmp/.zshrc
COPY .zshrc /root/.zshrc
ADD  .zshrc /root/.zshrc
ADD  .zshrc /root/.zshrc2

RUN useradd -m -s /bin/zsh sarnobat

# ugly, but a straight copy doesn't work
COPY .zshrc /home/sarnobat/
RUN cp /home/sarnobat/.zshrc /root/zshrc
RUN cp -v /root/zshrc /root/.zshrc

RUN find / -iname "parse*o"

WORKDIR /proj/
# RUN ./configure x86_64
RUN autoreconf --install
RUN ./configure arm64 --with-coverage
RUN make clean
RUN make coverage-text
RUN WITH_COVERAGE=1 make install
RUN touch "ubarak-[7249661751770303746].mp4"
# RUN cat INSTALL | /usr/local/bin/detox

# This doesn't do anything, only the symlink works
COPY .zshrc /root/
COPY .zshrc /proj/

WORKDIR /root/