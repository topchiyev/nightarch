#!/bin/bash
set -euo pipefail

cd "$HOME"

# Ensure required tools exist
sudo pacman -S --needed --noconfirm curl unzip

tmp_dir="$HOME/nightarch"

zipfile="$tmp_dir/nightarch.zip"

curl -fL "https://github.com/topchiyev/nightarch/archive/refs/heads/main.zip" -o "$zipfile"

unzip -q "$zipfile" -d "$tmp_dir"

repo_dir="$tmp_dir/nightarch-main"

if [[ ! -f "$repo_dir/install.sh" ]]; then
  echo "ERROR: install.sh not found in $repo_dir"
  exit 1
fi

bash "$repo_dir/install.sh"
