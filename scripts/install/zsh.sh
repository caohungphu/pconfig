#!/bin/bash
source "./install.sh"

cinfo "=== Installing zsh ==="

# Install zsh
if ! command -v zsh &>/dev/null; then
    install_with_distro $DISTRO zsh
else
    cwarn "zsh is already installed."
fi

# Configure zsh

# Oh-my-zsh
cinfo "Installing Oh My Zsh..."
if [ -d "${HOME}/.oh-my-zsh" ]; then
    cwarn "Oh My Zsh is already installed."
else
    cinfo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cinfo "Oh My Zsh installed."
fi

# Powerlevel10k
cinfo "Installing powerlevel10k..."
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    cwarn "powerlevel10k is already installed."
else
    cinfo "Installing theme powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    cinfo "theme powerlevel10k installed."
fi

# Plugins
cinfo "Installing zsh plugins..."
# zsh-autosuggestions
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    cwarn "zsh-autosuggestions is already installed."
else
    cinfo "Installing plugins zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    cinfo "plugins zsh-autosuggestions installed."
fi

# zsh-syntax-highlighting
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    cwarn "zsh-syntax-highlighting is already installed."
else
    cinfo "Installing plugins zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    cinfo "plugins zsh-syntax-highlighting installed."
fi

# zsh-history-substring-search
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search" ]; then
    cwarn "zsh-history-substring-search is already installed."
else
    cinfo "Installing plugins zsh-history-substring-search..."
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
    cinfo "plugins zsh-history-substring-search installed."
fi

# zsh-bat
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat" ]; then
    cwarn "zsh-bat is already installed."
else
    cinfo "Installing plugins zsh-bat..."
    git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat
    cinfo "plugins zsh-bat installed."
fi

cinfo "=== Installing zsh ==="
