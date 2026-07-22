#!/usr/bin/env bash

set -e

# ---------------------------
# Detect OS
# ---------------------------

if command -v zypper >/dev/null; then
    DISTRO="opensuse"
elif command -v pacman >/dev/null; then
    DISTRO="arch"
elif command -v apt >/dev/null; then
    DISTRO="ubuntu"
elif command -v dnf >/dev/null; then
    DISTRO="fedora"
else
    echo "Unsupported distribution"
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles..."

mkdir -p ~/.config

# --------------------------
# Neovim
# --------------------------

ln -sfn "$DOTFILES_DIR/nvim" ~/.config/nvim

mkdir -p "$HOME/.local/share/nvim/lazy"

if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
    git clone --filter=blob:none \
        https://github.com/folke/lazy.nvim.git \
        "$HOME/.local/share/nvim/lazy/lazy.nvim"
fi

# --------------------------
# Git
# --------------------------

mkdir -p ~/.config/git

ln -sfn "$DOTFILES_DIR/git/aliases" ~/.config/git/aliases
ln -sfn "$DOTFILES_DIR/git/ignore" ~/.config/git/ignore
ln -sfn "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig

# ----------------------------
# GitHub CLI
# ----------------------------

if command -v gh >/dev/null 2>&1; then
    if ! gh auth status >/dev/null 2>&1; then
        echo
        echo "GitHub CLI is not authenticated."
        echo "Run: gh auth login"
    fi
fi


# ----------------------------
# Install Packages
# ----------------------------

case "$DISTRO" in
opensuse)
    bash "$DOTFILES_DIR/packages/opensuse.sh"
    ;;
arch)
    bash "$DOTFILES_DIR/packages/arch.sh"
    ;;
ubuntu)
    bash "$DOTFILES_DIR/packages/ubuntu.sh"
    ;;
fedora)
    bash "$DOTFILES_DIR/packages/fedora.sh"
    ;;
esac

# ----------------------------
# Install Oh My Zsh
# ----------------------------

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ----------------------------
# Install Zsh Plugins
# ----------------------------

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone \
        https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone \
        https://github.com/zsh-users/zsh-syntax-highlighting \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
    git clone \
        https://github.com/zsh-users/zsh-completions \
        "$ZSH_CUSTOM/plugins/zsh-completions"
fi

# --------------------------
# Zsh Configuration
# --------------------------

mkdir -p ~/.config/zsh

ln -sfn "$DOTFILES_DIR/zsh/aliases.zsh" ~/.config/zsh/aliases.zsh
ln -sfn "$DOTFILES_DIR/zsh/bindings.zsh" ~/.config/zsh/bindings.zsh
ln -sfn "$DOTFILES_DIR/zsh/completion.zsh" ~/.config/zsh/completion.zsh
ln -sfn "$DOTFILES_DIR/zsh/env.zsh" ~/.config/zsh/env.zsh
ln -sfn "$DOTFILES_DIR/zsh/functions.zsh" ~/.config/zsh/functions.zsh
ln -sfn "$DOTFILES_DIR/zsh/options.zsh" ~/.config/zsh/options.zsh

# --------------------------
# CLI Tools
# --------------------------

mkdir -p ~/.local/bin

for file in "$DOTFILES_DIR"/bin/*; do
    [ -f "$file" ] || continue
    ln -sfn "$file" "$HOME/.local/bin/$(basename "$file")"
done



# --------------------------
# tmux
# --------------------------

ln -sfn "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf

mkdir -p "$HOME/.tmux/plugins"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone \
        https://github.com/tmux-plugins/tpm \
        "$HOME/.tmux/plugins/tpm"
fi

if command -v tmux >/dev/null && [ -d "$HOME/.tmux/plugins/tpm" ]; then
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi

# ----------------------------
# Install uv
# ----------------------------

if ! command -v uv >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

export PATH="$HOME/.local/bin:$PATH"

# ----------------------------
# Python Tools
# ----------------------------

uv tool install ruff || true
uv tool install black || true
uv tool install pyright || true
uv tool install debugpy || true

# ----------------------------
# LazyDocker
# ----------------------------

if ! command -v lazydocker >/dev/null 2>&1; then
    VERSION=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep '"tag_name"' | cut -d '"' -f4)

    curl -Lo /tmp/lazydocker.tar.gz \
        "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${VERSION#v}_Linux_x86_64.tar.gz"

    tar -xf /tmp/lazydocker.tar.gz -C /tmp

    sudo install /tmp/lazydocker /usr/local/bin

    rm -f /tmp/lazydocker /tmp/lazydocker.tar.gz
fi

# ----------------------------
# Docker
# ----------------------------

if command -v docker >/dev/null 2>&1; then
    sudo systemctl enable docker
    sudo systemctl start docker

    sudo usermod -aG docker "$USER"
fi

# ----------------------------
# Fonts
# ----------------------------

bash "$DOTFILES_DIR/scripts/install-fonts.sh"

# ----------------------------
# Bootstrap Neovim
# ----------------------------

if command -v nvim >/dev/null 2>&1; then
    nvim --headless "+Lazy! sync" +qa
fi


echo
echo "====================================="
echo " Dotfiles installed successfully!"
echo "====================================="
echo
echo "Restart your terminal (or run: exec zsh)"
echo
echo "If Docker was installed:"
echo "  newgrp docker"
echo
echo "Happy coding!"
