cinfo() {
    # Usage: cinfo "message"
    # Print an info message in green
    echo -e "${COLOR_GREEN}[INFO] $1${COLOR_RESET}"
}

cwarn() {
    # Usage: cwarn "message"
    # Print a warning message in yellow
    echo -e "${COLOR_YELLOW}[WARN] $1${COLOR_RESET}"
}

cerror() {
    # Usage: cerror "message"
    # Print an error message in red
    echo -e "${COLOR_RED}[ERROR] $1${COLOR_RESET}"
}

check_distro() {
    # Usage: check_distro
    # Check the distribution of the system
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        export DISTRO=$ID
    else
        cerror "Cannot detect distribution. /etc/os-release not found"
        exit 1
    fi

    cinfo "Distro: $DISTRO"
}

check_kernel() {
    # Usage: check_kernel
    # Check the kernel version
    if [ -z "$KERNEL" ]; then
        export KERNEL=$(uname -r)
    fi
    cinfo "Kernel: $KERNEL"
}

check_machine() {
    # Usage: check_machine
    # Check the uname version
    if [ -z "$MACHINE" ]; then
        export MACHINE=$(uname -m)
    fi
    cinfo "Machine: $MACHINE"
}

update_system() {
    # Usage: update_system
    # Update the system based on the distribution
    cinfo "Updating system..."

    case "$DISTRO" in
    ubuntu | debian)
        sudo apt update -y
        sudo apt upgrade -y
        ;;
    centos | rhel | fedora)
        if command -v dnf >/dev/null 2>&1; then
            sudo dnf update -y
        else
            sudo yum update -y
        fi
        ;;
    arch | manjaro)
        sudo pacman -Syu --noconfirm
        ;;
    opensuse | suse)
        sudo zypper refresh
        sudo zypper update -y
        ;;
    *)
        cerror -e "Unsupported distribution: $DISTRO"
        echo "Please update manually."
        exit 1
        ;;
    esac

    cinfo "System updated successfully!"
}

check_shell() {
    # Usage: check_shell
    # Check the shell being used
    if [ -z "$SHELL" ]; then
        SHELL=$(basename "$0")
    fi
    cinfo "Shell: $SHELL"
}

check_bin() {
    # Usage: check_bin "bin"
    # Check if a binary is available in the system
    if ! command -v $1 &>/dev/null; then
        cerror "$1 is not installed."
        exit 1
    else
        cinfo "$1 is installed."
    fi
}
