#!/bin/bash

# Define variables
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
    echo "Repository cloned successfully to ${P_PATH_REPO}."
else
    git -C "${P_PATH_REPO}" pull origin main
    if [ $? -ne 0 ]; then
        echo "Failed to update repository."
        exit 1
    fi
    echo "Repository updated successfully."
fi

# Load libraries
source "${P_PATH_LIBS}/central.sh"

cinfo "Initalizing pconfig..."

# Check info
check_distro
check_shell
check_kernel
check_machine

# Update system
update_system

cinfo "Initialization complete."
