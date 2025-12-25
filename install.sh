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

cat <<'EOF'
============================================================
                 NightArch Installer
============================================================

This installer will configure your system according to
the NightArch profile.

PLEASE CONFIRM THE FOLLOWING BEFORE CONTINUING:

  • This is a FRESH Arch Linux installation
    (no desktop environment installed yet)

  • You are running this as a NORMAL USER
    (not root)

  • The current user has PASSWORDLESS sudo access

  • You understand that this will MODIFY system
    configuration and install packages

------------------------------------------------------------
EOF

# Basic sanity checks
if [[ "$EUID" -eq 0 ]]; then
  echo "ERROR: Do not run NightArch as root."
  exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
  echo "ERROR: NightArch requres sudo to be installed."
  echo "Please install it, reboot and start over."
  exit 1
fi

# Must be passwordless sudoer
if ! sudo -n true 2>/dev/null; then
  echo "ERROR: NightArch requires passwordless sudo"
  exit 1
fi

echo
read -rp "Type 'YES' to start NightArch installation: " CONFIRM

if [[ "$CONFIRM" != "YES" ]]; then
  echo "Installation aborted by user."
  exit 0
fi

echo
echo ">>> Starting NightArch installation..."
echo

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

cat <<'EOF'

------------------------------------------------------------
NightArch installation completed successfully.

Please reboot your system to apply all changes:

  sudo reboot

------------------------------------------------------------

EOF
