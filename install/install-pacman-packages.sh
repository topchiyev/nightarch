#!/bin/bash

#must be passwordless sudoer

ARCH="$(uname -m)"
IS_RPI=false

if [[ -f /proc/device-tree/model ]] &&
  grep -qi 'raspberry pi' /proc/device-tree/model; then
  IS_RPI=true
fi

sudo pacman -S --needed - <../packages/pacman-packages-all.txt

if [[ "$ARCH" == "aarch64" ]]; then
  sudo pacman -S --needed - <../packages/pacman-packages-arm64.txt
fi
