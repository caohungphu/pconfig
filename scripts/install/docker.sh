# Install Docker
if ! command -v docker &>/dev/null; then
    cinfo "Installing Docker..."
    curl -fsSL https://get.docker.com | sudo sh
    sudo usermod -aG docker $USER
    cinfo "Docker installed..."
else
    einfo "Docker is already installed."
fi
