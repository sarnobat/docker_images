# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set the maintainer label
LABEL maintainer="your-email@example.com"

# Update the package list and install required packages
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    curl \
    spim \
    make \
    wget \
    m4 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Flex 2.6.4
RUN wget https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz && \
    tar -xzf flex-2.6.4.tar.gz && \
    cd flex-2.6.4 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf flex-2.6.4 flex-2.6.4.tar.gz

# Install Bison 3.8.2
RUN wget http://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.gz && \
    tar -xzf bison-3.8.2.tar.gz && \
    cd bison-3.8.2 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf bison-3.8.2 bison-3.8.2.tar.gz

# Set the library path
ENV LD_LIBRARY_PATH=/usr/local/lib

# Set the working directory
WORKDIR /usr/sample-compiler

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Compile the application
RUN make
