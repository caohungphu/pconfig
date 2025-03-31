#!/bin/bash

export P_REPO="https://github.com/caohungphu/pconfig"
export P_PATH_REPO="${HOME}/.pconfig"
export P_PATH_LIBS="${P_PATH_REPO}/libs"
export P_PATH_CONFIG="${P_PATH_REPO}/config"
export P_PATH_SCRIPTS="${P_PATH_REPO}/scripts"

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

cinfo "... Installing pconfig ..."
check_distro
check_shell
update_system
