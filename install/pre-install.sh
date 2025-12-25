#!/bin/bash
set -euo pipefail

yes | sudo pacman -S --needed iptables-nft nftables iwd || true
sudo pacman -S --needed --noconfirm iwd || true
sudo systemctl disable --now NetworkManager || true
sudo pacman -R --noconfirm networkmanager || true
sudo systemctl enable --now iwd || true
