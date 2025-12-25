#!/bin/bash
set -euo pipefail

if [[ ! -d $HOME/.local/share/wallpapers ]]; then
  mkdir -p $HOME/.local/share/wallpapers
fi

cp -r $ROOT_DIR/wallpapers/* $HOME/.local/share/wallpapers/
