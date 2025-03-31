# Install tmux
check_bin tmux
if $?; then
    cinfo "tmux is already installed."
    return
fi
cinfo "Installing tmux..."
case "$DISTRO" in
ubuntu | debian)
    sudo apt install tmux -y
    ;;
centos | rhel | fedora)
    if command -v dnf >/dev/null 2>&1; then
        sudo dnf install tmux -y
    else
        sudo yum install tmux -y
    fi
    ;;
arch | manjaro)
    sudo pacman -S tmux --noconfirm
    ;;
opensuse | suse)
    sudo zypper install tmux -y
    ;;
*)
    cerror -e "Unsupported distribution: $DISTRO"
    echo "Please install tmux manually."
    exit 1
    ;;
esac
cinfo "tmux installed successfully!"
