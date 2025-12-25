#!/bin/bash
set -euo pipefail

sudo pacman -S --needed --noconfirm iptables-nft nftables iwd || true
sudo systemctl disable --now NetworkManager || true
sudo pacman -R --noconfirm networkmanager || true
sudo systemctl enable --now iwd || true
