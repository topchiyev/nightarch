#!/bin/bash
set -euo pipefail

cp -f "$ROOT_DIR/shconfig/bash_profile.txt" "$HOME/.bash_profile"
cp -f "$ROOT_DIR/shconfig/bashrc.txt" "$HOME/.bashrc"
