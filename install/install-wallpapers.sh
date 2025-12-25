#!/bin/bash
set -euo pipefail

echo '--- Started wallpaper installation ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished wallpaper installation ---"
      else
        echo "--- Failed wallpaper installation ---"
      fi' EXIT

if [[ ! -d "$HOME/.local/share/wallpapers" ]]; then
  mkdir -p "$HOME/.local/share/wallpapers"
fi

cp -rf "$ROOT_DIR/wallpapers" "$HOME/.local/share/wallpapers"
