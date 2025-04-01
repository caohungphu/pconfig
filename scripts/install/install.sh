#!/bin/bash

# Configuration
export P_PATH_TEMP="/tmp"
export P_PATH_REPO="${HOME}/.pconfig"
export P_PATH_LIBS="${P_PATH_REPO}/libs"
export P_PATH_CONFIG="${P_PATH_REPO}/configs"
export P_PATH_SCRIPTS="${P_PATH_REPO}/scripts"

# Load libraries
source "${P_PATH_LIBS}/central.sh"

add_repo_with_distro() {
    # Function to add a repository using the appropriate package manager for the distribution
    # Arguments:
    #   $1: Distribution name (e.g., ubuntu, debian, fedora, arch)
    #   $2: Repository URL to add
    # Example usage:
    #   add_repo_with_distro ubuntu ppa:git-core/ppa
    #   add_repo_with_distro fedora https://download.docker.com/linux/fedora/docker-ce.repo
    local distro=$1
    local repo=$2

    cinfo "Adding repository for $distro..."

    case $distro in
    ubuntu | debian)
        sudo add-apt-repository -y $repo
        ;;
    fedora | rhel | centos | almalinux)
        sudo dnf config-manager --add-repo $repo
        ;;
    arch)
        sudo pacman-key --init
        sudo pacman-key --populate archlinux
        sudo pacman-key --recv-keys $(curl -sSL $repo | grep 'KEY' | awk '{print $2}')
        ;;
    *)
        echo "Unsupported distribution: $distro"
        echo "Please add the repository manually."
        echo "Exiting..."
        exit 1
        ;;
    esac
}

# Install with distro
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
    fedora | rhel | centos | almalinux)
        if command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y $package
        else
            sudo yum install -y $package
        fi
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
