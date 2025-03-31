#!/bin/bash
source "./install.sh"

cinfo "=== Installing tmux ==="

# Install tmux
if ! command -v tmux &>/dev/null; then
    install_with_distro $DISTRO tmux
else
    cwarn "tmux is already installed."
fi

# Configure tmux
source_conf="${P_PATH_CONFIG}/.tmux.conf"
tmux_conf="${HOME}/.tmux.conf"
backup_conf="${HOME}/.tmux.conf.bak"
if [ -f "${tmux_conf}" ] && [ ! -L "${tmux_conf}" ]; then
    cinfo "Backing up existing .tmux.conf to ${backup_conf}"
    mv "${tmux_conf}" "${backup_conf}"
    cinfo "Creating symbolic link to ${source_conf}"
    ln -s "${source_conf}" "${tmux_conf}"

# Case 2: If .tmux.conf is a symlink
elif [ -L "${tmux_conf}" ]; then
    cinfo "Removing existing symlink at ${tmux_conf}"
    rm "${tmux_conf}"
    cinfo "Creating new symbolic link to ${source_conf}"
    ln -s "${source_conf}" "${tmux_conf}"

# Case 3: If .tmux.conf doesn't exist
elif [ ! -e "${tmux_conf}" ]; then
    cinfo "No .tmux.conf found, creating symbolic link to ${source_conf}"
    ln -s "${source_conf}" "${tmux_conf}"

else
    cerror "Unexpected state for ${tmux_conf}. Please check manually."
    return 1
fi

cinfo "=== Installing tmux ==="
