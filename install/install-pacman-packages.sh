#!/bin/bash

sudo pacman -S --needed --noconfirm - <$ROOT_DIR/packages/pacman-packages-all.txt

if [[ "$ARCH" == "aarch64" ]]; then
  sudo pacman -S --needed --noconfirm - <$ROOT_DIR/packages/pacman-packages-arm64.txt
  if [[ "$IS_RPI" ]]; then
    sudo pacman -S --needed --noconfirm - <$ROOT_DIR/packages/pacman-packages-rpi5.txt
  fi
elif [[ "$ARCH" == "x86_64" ]]; then
  sudo pacman -S --needed --noconfirm - <$ROOT_DIR/packages/pacman-packages-amd64.txt
fi
