#!/bin/bash
source "./install.sh"

cinfo "=== Installing nvim ==="

# Install nvim
if ! command -v nvim &>/dev/null; then
    cinfo "Downloading nvim..."
    curl -L -o ${P_PATH_TEMP:-/tmp}/nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    if [ $? -ne 0 ]; then
        cerror "Failed to download nvim. Please check your internet connection."
        exit 1
    fi
    if [ -d /opt/nvim ]; then
        cinfo "Removing old nvim directory..."
        sudo rm -rf /opt/nvim
    fi
    cinfo "Extracting nvim..."
    sudo tar -C /opt -xzf ${P_PATH_TEMP:-/tmp}/nvim-linux-x86_64.tar.gz
    if [ $? -ne 0 ]; then
        cerror "Failed to extract nvim. Please check the downloaded file."
        exit 1
    fi
    cinfo "nvim installed successfully to /opt/nvim"
    cinfo "Remove tmp file..."
    rm -rf ${P_PATH_TEMP:-/tmp}/nvim-linux-x86_64.tar.gz
else
    cwarn "nvim is already installed."
fi

# Add to config
add_to_config "${HOME}/.bashrc" "export PATH=\$PATH:/opt/nvim-linux-x86_64/bin"
add_to_config "${HOME}/.zshrc" "export PATH=\$PATH:/opt/nvim-linux-x86_64/bin"

# Create symlink for nvim configuration
setup_nvim_symlink() {
    local source_conf="${P_PATH_CONFIG}/nvim"
    local current_conf="${HOME}/.config/nvim"
    local backup_conf="${HOME}/.config/nvim.backup"

    [ -d "${HOME}/.config" ] || mkdir -p "${HOME}/.config"

    if [ -e "$current_conf" ] || [ -L "$current_conf" ]; then
        if [ ! -L "$current_conf" ]; then
            mv "$current_conf" "$backup_conf"
            echo "Moved existing $current_conf to $backup_conf"
        else
            rm "$current_conf"
            echo "Removed existing symlink at $current_conf"
        fi
    fi

    ln -sf "$source_conf" "$current_conf"
    echo "Created/Updated symlink from $source_conf to $current_conf"
}

setup_nvim_symlink

cinfo "=== Installing nvim ==="
