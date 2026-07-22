#!/usr/bin/env bash

sudo dnf upgrade -y

sudo dnf install -y \
    git \
    curl \
    wget \
    gcc \
    gcc-c++ \
    make \
    cmake \
    ninja-build \
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
    fd-find \
    fzf \
    tree \
    unzip \
    zip \
    xclip \
    wl-clipboard \
    neovim \
    python3 \
    python3-pip \
    nodejs \
    npm \
    lua \
    luarocks \
    bear \
    kubernetes-client \
    tcpdump \
    wireshark \
    nmap \
    iperf3
