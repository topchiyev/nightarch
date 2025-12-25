#!/bin/bash
set -euo pipefail

echo '--- Started bin installation ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished bin installation ---"
      else
        echo "--- Failed bin installation ---"
      fi' EXIT

trap 'status=$?;
      echo "ERROR: bin installation failed at line ${BASH_LINENO[0]}: ${BASH_COMMAND}" >&2;
      exit $status' ERR

if [[ -z "${ROOT_DIR:-}" ]]; then
  echo "ERROR: ROOT_DIR is not set. Run install.sh from the repo root." >&2
  exit 1
fi

if [[ ! -d "$HOME/.local/share/bin" ]]; then
  mkdir -p "$HOME/.local/share/bin"
fi

if [[ ! -d "$ROOT_DIR/bin" ]]; then
  echo "ERROR: bin directory not found at $ROOT_DIR/bin" >&2
  exit 1
fi

shopt -s nullglob
bin_items=("$ROOT_DIR/bin/"*)
shopt -u nullglob

if (( ${#bin_items[@]} == 0 )); then
  echo "WARN: No files found in $ROOT_DIR/bin to install." >&2
  exit 0
fi

cp -r "${bin_items[@]}" "$HOME/.local/share/bin/"

# Make each .sh script executable only if it exists
for sh_file in "$HOME/.local/share/bin"/*.sh; do
  [[ -f "$sh_file" ]] && chmod +x "$sh_file"
done
