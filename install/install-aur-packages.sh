#!/bin/bash
set -euo pipefail

echo '--- Started AUR package installation ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished AUR package installation ---"
      else
        echo "--- Failed AUR package installation ---"
      fi' EXIT

# Install AUR packages from a file if there are any
install_aur_packages_from_file() {
  local pkg_file="$1"
  mapfile -t pkgs < <(grep -vE '^\s*#|^\s*$' "$pkg_file" 2>/dev/null || true)
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    yay -S --needed --noconfirm "${pkgs[@]}"
  fi
}

install_aur_packages_from_file "$ROOT_DIR/packages/aur-packages-all.txt"

if [[ "$ARCH" == "aarch64" ]]; then
  install_aur_packages_from_file "$ROOT_DIR/packages/aur-packages-arm64.txt"
elif [[ "$ARCH" == "x86_64" ]]; then
  install_aur_packages_from_file "$ROOT_DIR/packages/aur-packages-amd64.txt"
fi
