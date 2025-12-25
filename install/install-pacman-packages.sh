#!/bin/bash
set -euo pipefail

# Install a set of packages from a file if it contains any entries
install_packages_from_file() {
  local pkg_file="$1"
  # Read non-empty, non-comment lines into an array
  mapfile -t pkgs < <(grep -vE '^\s*#|^\s*$' "$pkg_file" 2>/dev/null || true)
  # Only run pacman if there are packages to install
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    sudo pacman -S --needed --noconfirm "${pkgs[@]}"
  fi
}

# All architectures
install_packages_from_file "$ROOT_DIR/packages/pacman-packages-all.txt"

# Architecture-specific sets
if [[ "$ARCH" == "aarch64" ]]; then
  install_packages_from_file "$ROOT_DIR/packages/pacman-packages-arm64.txt"
  if [[ "${IS_RPI:-}" ]]; then
    install_packages_from_file "$ROOT_DIR/packages/pacman-packages-rpi5.txt"
  fi
elif [[ "$ARCH" == "x86_64" ]]; then
  install_packages_from_file "$ROOT_DIR/packages/pacman-packages-amd64.txt"
fi
