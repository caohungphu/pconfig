#!/bin/bash
source "./install.sh"

cinfo "=== Installing batcat/bat ==="

# Install batcat/bat
if ! command -v bat &>/dev/null; then
    install_with_distro $DISTRO bat
else
    cwarn "batcat/bat is already installed."
fi

cinfo "=== Installing batcat/bat ==="
