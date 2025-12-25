#!/bin/bash
set -euo pipefail

# Header and footer
echo '--- Started YAY installation ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished YAY installation ---"
      else
        echo "--- Failed YAY installation ---"
      fi' EXIT

if ! command -v yay >/dev/null 2>&1; then
  cd "$HOME"
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi
