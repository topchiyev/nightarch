#!/bin/bash
set -euo pipefail

echo '--- Started post-install tasks ---'
trap 'status=$?; if [ $status -eq 0 ]; then
        echo "--- Finished post-install tasks ---"
      else
        echo "--- Failed post-install tasks ---"
      fi' EXIT

# Add any post-install commands here, or leave empty for a no-op.
