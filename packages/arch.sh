#!/usr/bin/env bash

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm \
    git \
    curl \
    wget \
    gcc \
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
    github-cli \
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
    python \
    python-pip \
    nodejs \
    npm \
    lua \
    luarocks \
    bear \
    kubectl \
    tcpdump \
    wireshark-qt \
    nmap \
    iperf3
