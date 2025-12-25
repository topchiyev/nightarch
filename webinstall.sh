#!/bin/bash
set -euo pipefail

cd "$HOME"

# Ensure required tools exist
sudo pacman -S --needed --noconfirm curl unzip

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

zipfile="$tmpdir/nightarch.zip"

curl -fL "https://github.com/topchiyev/nightarch/archive/refs/heads/main.zip" -o "$zipfile"

unzip -q "$zipfile" -d "$tmpdir"

# GitHub zip extracts into nightarch-main/
repo_dir="$tmpdir/nightarch-main"

if [[ ! -f "$repo_dir/install.sh" ]]; then
  echo "ERROR: install.sh not found in $repo_dir"
  exit 1
fi

bash "$repo_dir/install.sh"
