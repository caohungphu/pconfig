#!/bin/bash
source "./install.sh"

cinfo "=== Installing nvim ==="

# Install nvim
if ! command -v nvim &>/dev/null; then
    install_with_distro $DISTRO nvim
else
    cwarn "nvim is already installed."
fi

cinfo "=== Installing nvim ==="
