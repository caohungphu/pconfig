install_soft() {
    # Usage: install_bin "bin"
    # Check if a binary is available in the system
    if ! command -v $1 &>/dev/null; then
        cerror "$1 is not installed."
        exit 1
    else
        cinfo "$1 is installed."
    fi
}
