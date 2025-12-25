#!/bin/bash
set -euo pipefail

if ! command -v yay >/dev/null 2>&1; then
  cd "$HOME"
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi
