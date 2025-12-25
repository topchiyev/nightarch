#!/bin/bash
set -euo pipefail

echo '--- Started config installation ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished config installation ---"
      else
        echo "--- Failed config installation ---"
      fi' EXIT

if [[ ! -d "$HOME/.config" ]]; then
  mkdir -p "$HOME/.config"
fi

cp -rf "$ROOT_DIR/config" "$HOME/.config"
