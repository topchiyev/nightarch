#!/bin/bash
set -euo pipefail

if [[ ! -d "$HOME/.local/share/applications" ]]; then
  mkdir -p "$HOME/.local/share/applications"
fi

cp -rf "$ROOT_DIR/applications" "$HOME/.local/share/applications"
