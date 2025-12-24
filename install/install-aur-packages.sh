#!/bin/bash

yay -S --needed <$ROOT_DIR/packages/aur-packages-all.txt

if [[ "$ARCH" == "aarch64" ]]; then
  yay -S --needed - <$ROOT_DIR/packages/aur-packages-arm64.txt
elif [[ "$ARCH" == "x86_64" ]]; then
  yay -S --needed - <$ROOT_DIR/packages/aur-packages-amd64.txt
fi
