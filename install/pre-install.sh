#!/bin/bash
set -euo pipefail

echo '--- Started pre-install tasks ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished pre-install tasks ---"
      else
        echo "--- Failed pre-install tasks ---"
      fi' EXIT

# Your pre-install commands
yes | sudo pacman -S --needed iptables-nft nftables iwd || true
sudo pacman -S --needed --noconfirm iwd || true
sudo systemctl disable --now NetworkManager || true
sudo pacman -R --noconfirm networkmanager || true
sudo systemctl enable --now iwd || true
