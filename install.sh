#!/bin/bash

export P_REPO="https://github.com/caohungphu/pconfig"
export P_PATH_REPO="${HOME}/.pconfig"
export P_PATH_LIBS="${P_PATH_REPO}/libs"

# Clone the repository if it doesn't exist
if [ ! -d "${P_PATH_REPO}" ]; then
    git clone ${P_REPO} ${P_PATH_REPO}
    if [ $? -ne 0 ]; then
        echo "Error: Failed to clone repository."
        exit 1
    fi
else
    git pull origin main
    if [ $? -ne 0 ]; then
        echo "Error: Failed to update repository."
        exit 1
    fi
fi

# Load libraries
source "${P_PATH_LIBS}/central.sh"

# Main
cinfo "Initalizing pconfig..."
check_distro
check_shell
update_system
cinfo "Initialization complete."
