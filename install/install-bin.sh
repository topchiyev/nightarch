#!/bin/bash
set -euo pipefail

if [[ ! -d $HOME/.local/share/bin ]]; then
  mkdir -p $HOME/.local/share/bin
fi

cp -r $ROOT_DIR/bin/* $HOME/.local/share/bin/

for sh_file in "$HOME/.local/share/bin"/*.sh; do
  [[ -f "$sh_file" ]] && chmod +x "$sh_file"
done
