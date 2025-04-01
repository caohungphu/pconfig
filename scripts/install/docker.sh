#!/bin/bash
source "./install.sh"

cinfo "=== Installing docker ==="

# Install docker
if ! command -v docker &>/dev/null; then
    cinfo "Installing docker..."
    curl -fsSL https://get.docker.com | sudo sh
    if [ $? -ne 0 ]; then
        cerror "Failed to install docker."
        cinfo "Try installing docker with package manager..."
        install_with_distro $DISTRO "docker-ce docker-ce-cli containerd.io"
    fi
    cinfo "docker installed..."
else
    cwarn "docker is already installed."
fi

# Configure docker
sudo usermod -aG docker $USER
if [ $? -eq 0 ]; then
    cinfo "User $USER added to docker group. Please log out and log back in for the changes to take effect."
else
    cerror "Failed to add user $USER to docker group."
    exit 1
fi

cinfo "=== Installing docker ==="
