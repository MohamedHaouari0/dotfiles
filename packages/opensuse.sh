#!/usr/bin/env bash

sudo zypper refresh

sudo zypper install -y \
    git \
    curl \
    wget \
    gcc \
    gcc-c++ \
    make \
    cmake \
    ninja \
    clang \
    lldb \
    gdb \
    valgrind \
    cppcheck \
    docker \
    docker-compose \
    gh \
    tmux \
    zsh \
    ripgrep \
    fd \
    fzf \
    tree \
    unzip \
    zip \
    xclip \
    wl-clipboard \
    neovim \
    python313 \
    python313-pip \
    nodejs \
    npm \
    lua54 \
    luarocks \
    bear \
    k9s \
    kubernetes-client \
    tcpdump \
    wireshark \
    nmap \
    iperf
