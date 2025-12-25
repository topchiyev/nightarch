#!/bin/bash
set -euo pipefail

echo '--- Started shell config installation ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished shell config installation ---"
      else
        echo "--- Failed shell config installation ---"
      fi' EXIT

cp -f "$ROOT_DIR/shconfig/bash_profile.txt" "$HOME/.bash_profile"
cp -f "$ROOT_DIR/shconfig/bashrc.txt" "$HOME/.bashrc"
