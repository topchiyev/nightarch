#!/bin/bash
set -euo pipefail

# Install AUR packages from a file if it contains any entries
install_aur_packages_from_file() {
  local pkg_file="$1"
  # Read non-empty, non-comment lines into an array
  mapfile -t pkgs < <(grep -vE '^\s*#|^\s*$' "$pkg_file" 2>/dev/null || true)
  # Only run yay if there are packages to install
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    yay -S --needed --noconfirm "${pkgs[@]}"
  fi
}

# All architectures
install_aur_packages_from_file "$ROOT_DIR/packages/aur-packages-all.txt"

# Architecture-specific sets
if [[ "$ARCH" == "aarch64" ]]; then
  install_aur_packages_from_file "$ROOT_DIR/packages/aur-packages-arm64.txt"
elif [[ "$ARCH" == "x86_64" ]]; then
  install_aur_packages_from_file "$ROOT_DIR/packages/aur-packages-amd64.txt"
fi
