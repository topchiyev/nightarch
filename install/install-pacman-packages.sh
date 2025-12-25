#!/bin/bash
set -euo pipefail

echo '--- Started Pacman package installation ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished Pacman package installation ---"
      else
        echo "--- Failed Pacman package installation ---"
      fi' EXIT

# Install packages from a file if there are any
install_packages_from_file() {
  local pkg_file="$1"
  # Filter out empty lines and comments
  mapfile -t pkgs < <(grep -vE '^\s*#|^\s*$' "$pkg_file" 2>/dev/null || true)
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    sudo pacman -S --needed --noconfirm "${pkgs[@]}"
  fi
}

install_packages_from_file "$ROOT_DIR/packages/pacman-packages-all.txt"

if [[ "$ARCH" == "aarch64" ]]; then
  install_packages_from_file "$ROOT_DIR/packages/pacman-packages-arm64.txt"
  if [[ "${IS_RPI:-}" == "true" ]]; then
    install_packages_from_file "$ROOT_DIR/packages/pacman-packages-rpi5.txt"
  fi
elif [[ "$ARCH" == "x86_64" ]]; then
  install_packages_from_file "$ROOT_DIR/packages/pacman-packages-amd64.txt"
fi
