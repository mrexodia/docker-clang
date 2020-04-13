# Base image
FROM ubuntu:18.04

# Install dependencies
RUN apt-get -qq update \
 && apt-get install -qqy --no-install-recommends \
    autoconf \
    automake \
    dpkg-dev \
    file \
    git \
    make \
    patch \
    libc-dev \
    libc++-dev \
    libgcc-7-dev \
    libstdc++-7-dev \
    dirmngr \
    gnupg2 \
    lbzip2 \
    wget \
    xz-utils \
    libtinfo5 \
    ca-certificates \
    curl \
    unzip \
 && rm -rf /var/lib/apt/lists/*

# Install CMake
RUN cd /tmp \
 && wget https://github.com/Kitware/CMake/releases/download/v3.16.6/cmake-3.16.6-Linux-x86_64.sh \
 && chmod +x ./cmake-3.16.6-Linux-x86_64.sh \
 && ./cmake-3.16.6-Linux-x86_64.sh --prefix=/usr --skip-license \
 && rm cmake-3.16.6-Linux-x86_64.sh

# Install Ninja
RUN cd /tmp \
 && wget https://github.com/ninja-build/ninja/releases/download/v1.10.0/ninja-linux.zip \
 && unzip ninja-linux.zip \
 && chmod +x ninja \
 && mv ninja /usr/bin \
 && rm ninja-linux.zip

# Install Clang
RUN curl -SL https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz \
    | tar -xJC . \
 && mv clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04 clang_10.0.0 \
 && echo 'export PATH=/clang_10.0.0/bin:$PATH' >> ~/.bashrc \
 && echo 'export LD_LIBRARY_PATH=/clang_10.0.0/lib:$LD_LIBRARY_PATH' >> ~/.bashrc

# Start from a Bash prompt
CMD [ "/bin/bash" ]
