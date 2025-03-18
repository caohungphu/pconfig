cinfo() {
    # Usage: cinfo "message"
    echo -e "${COLOR_GREEN}[INFO] $1${COLOR_RESET}"
}

cwarn() {
    # Usage: cwarn "message"
    echo -e "${COLOR_YELLOW}[WARN] $1${COLOR_RESET}"
}

cerror() {
    # Usage: cerror "message"
    echo -e "${COLOR_RED}[ERROR] $1${COLOR_RESET}"
}

check_distro() {
    # Usage: check_distro
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$NAME
    else
        DISTRO=$(uname -s)
    fi
    cinfo "Distro: $DISTRO"
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
