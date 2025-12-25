#!/bin/bash
set -euo pipefail

export ROOT_DIR=$(dirname "$(realpath "$0")")
export ARCH="$(uname -m)"

IS_RPI=false
if [[ -f /proc/device-tree/model ]] &&
  grep -qi 'raspberry pi' /proc/device-tree/model; then
  IS_RPI=true
fi
export IS_RPI

if ! command -v sudo >/dev/null 2>&1; then
  echo "NightArch requres sudo to be installed."
  echo "Please install it, reboot and start over."
  exit 1
fi

# Must be passwordless sudoer
if ! sudo -n true 2>/dev/null; then
  echo "NightArch requires passwordless sudo"
  exit 1
fi

chmod +x $ROOT_DIR/install/*.sh

if [[ "$ARCH" == "aarch64" ]]; then
  sudo pacman-key --populate archlinuxarm
fi

sudo pacman -Syu --noconfirm

bash $ROOT_DIR/install/install-yay.sh
bash $ROOT_DIR/install/pre-install.sh
bash $ROOT_DIR/install/install-pacman-packages.sh
bash $ROOT_DIR/install/install-aur-packages.sh
bash $ROOT_DIR/install/install-config.sh
bash $ROOT_DIR/install/install-wallpapers.sh
bash $ROOT_DIR/install/install-bin.sh
bash $ROOT_DIR/install/install-shconfig.sh
bash $ROOT_DIR/install/post-install.sh
