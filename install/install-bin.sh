#!/bin/bash
set -euo pipefail

echo '--- Started bin installation ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished bin installation ---"
      else
        echo "--- Failed bin installation ---"
      fi' EXIT

if [[ ! -d "$HOME/.local/share/bin" ]]; then
  mkdir -p "$HOME/.local/share/bin"
fi

cp -r "$ROOT_DIR/bin/"* "$HOME/.local/share/bin/"

# Make each .sh script executable only if it exists
for sh_file in "$HOME/.local/share/bin"/*.sh; do
  [[ -f "$sh_file" ]] && chmod +x "$sh_file"
done
