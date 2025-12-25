#!/bin/bash
set -euo pipefail

echo '--- Started bin installation ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished bin installation ---"
      else
        echo "--- Failed bin installation ---"
      fi' EXIT

if [[ ! -d "$ROOT_DIR/bin" ]]; then
  exit 0
fi

if [[ ! -d "$HOME/.local/share/bin" ]]; then
  mkdir -p "$HOME/.local/share/bin"
fi

src_files=("$ROOT_DIR/bin/"*)

for src_file in "${src_files[@]}"; do
  file_name="$(basename "$src_file")"
  dest_file="$ROOT_DIR/bin/$file_name"
  cp -f "$src_file" "$dest_file"
  chmod +x "$dest_file"
done
