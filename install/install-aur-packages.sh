#!/bin/bash

yay -S --needed <../packages/aur-packages.txt

if [[ "$ARCH" == "aarch64" ]]; then
  yay -S --needed - <../packages/aur-packages-arm64.txt
else if [[ "$ARCH" == "x86_64"]]; then
  yay -S --needed - <../packages/aur-packages-amd64.txt
fi
