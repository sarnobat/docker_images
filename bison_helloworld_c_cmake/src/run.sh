#!/bin/sh

#----------------------------------------------------------------------------
# DESCRIPTION			
# DATE				2025
# AUTHOR			ss401533@gmail.com
#----------------------------------------------------------------------------
# template found at ~/.vim/sh_header.temp

set -o errexit
echo `date +%s::`"$0" >> ~/db.git/command_history.txt >> ~/db.git/command_history_timestamped.txt

cat <<EOF | batcat --style=plain --paging=never --language sh --theme TwoDark
make dist  # copies executable with uname-lowercase suffix
make run   # runs the program
make clean-temp  # removes generated flex/bison and object files
EOF

cat <<EOF | tee /tmp/make.sh | batcat --style=plain --paging=never --language sh --theme TwoDark
set -e
cd /Volumes/git/github/2024/docker_images/bison_helloworld_c_cmake/src && mkdir -p build && cd build && cmake --graphviz=call_graph.dot .. && make clean && make
pwd
echo "hello world" | ./helloworld
EOF

cat <<EOF | batcat --style=plain --paging=never --language sh --theme TwoDark
(-) CMake - cross platform
(-) IMake - cross platform (old)
(-) automake - GNU legacy projects

https://github.com/sarnobat/cpp_makefile_helloworld

sh /tmp/make.sh
EOF

cat <<EOF | batcat --style=plain --paging=never --language sh --theme TwoDark
I don't think we need the Dockerfile. I just compile it on Mac. But maybe for long term, I should so I can lock down the versions.
EOF
