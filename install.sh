#!/bin/bash

export ROOT_DIR=$(dirname "$(realpath "$0")")
export ARCH="$(uname -m)"

IS_RPI=false
if [[ -f /proc/device-tree/model ]] &&
  grep -qi 'raspberry pi' /proc/device-tree/model; then
  IS_RPI=true
fi
export IS_RPI

# Must be passwordless sudoer
if sudo -n true 2>/dev/null; then
  echo "NightArch requires passwordless sudo"
  exit 1
fi

chmod +x $ROOT_DIR/install/*.sh

bash $ROOT_DIR/install/install-yay.sh
bash $ROOT_DIR/install/install-pacman-packages.sh
bash $ROOT_DIR/install/install-aur-packages.sh
