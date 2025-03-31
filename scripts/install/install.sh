#!/bin/bash

# Configuration
export P_PATH_TEMP="/tmp"
export P_PATH_REPO="${HOME}/.pconfig"
export P_PATH_LIBS="${P_PATH_REPO}/libs"
export P_PATH_CONFIG="${P_PATH_REPO}/configs"
export P_PATH_SCRIPTS="${P_PATH_REPO}/scripts"

# Load libraries
source "${P_PATH_LIBS}/central.sh"

# Function to check the distribution
install_with_distro() {
    # Function to install a package using the appropriate package manager for the distribution
    # Arguments:
    #   $1: Distribution name (e.g., ubuntu, debian, fedora, arch)
    #   $2: Package name to install
    # Example usage:
    #   install_with_distro ubuntu git
    #   install_with_distro fedora vim
    local distro=$1
    local package=$2

    cinfo "Installing $package for $distro..."

    case $distro in
    ubuntu | debian)
        sudo apt-get install -y $package
        ;;
    fedora)
        sudo dnf install -y $package
        ;;
    arch)
        sudo pacman -S --noconfirm $package
        ;;
    *)
        echo "Unsupported distribution: $distro"
        echo "Please install $package manually."
        echo "Exiting..."
        exit 1
        ;;
    esac
}

# main function
main() {
    check_distro
    check_kernel
    check_machine
}

main
