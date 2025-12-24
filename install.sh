#!/bin/bash

export HAS_SUDO="$(sudo -n true 2>/dev/null)"
export ARCH="$(uname -m)"

IS_RPI=false
if [[ -f /proc/device-tree/model ]] &&
  grep -qi 'raspberry pi' /proc/device-tree/model; then
  IS_RPI=true
fi

export IS_RPI

# Must be passwordless sudoer
if ! HAS_SUDO; then
  echo "NightArch requires passwordless sudo"
  exit 1
fi

chmod +x install/*.sh

bash install/install-yay.sh
bash install/install-pacman-packages.sh
bash install/install-aur-packages.sh
