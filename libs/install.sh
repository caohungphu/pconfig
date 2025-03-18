update_system() {
    # Update system
    cinfo "Updating system..."
    sudo apt update -y
    sudo apt upgrade -y
    cinfo "System updated..."
}

install_tmux() {
    # Install tmux
    if ! command -v tmux &>/dev/null; then
        cinfo "Installing tmux..."
        sudo apt install tmux -y
        cinfo "tmux installed..."
    else
        cinfo "tmux is already installed."
    fi
}

install_docker() {
    # Install Docker
    if ! command -v docker &>/dev/null; then
        cinfo "Installing Docker..."
        curl -fsSL https://get.docker.com | sudo sh
        sudo usermod -aG docker $USER
        cinfo "Docker installed..."
    else
        einfo "Docker is already installed."
    fi
}
