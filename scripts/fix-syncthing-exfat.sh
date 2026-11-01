#!/usr/bin/env bash
# exFAT has no Linux permission model, so Syncthing can fail to create directories
# when a new device is paired. This pulls the failing paths out of the container
# logs and pre-creates them. Afterwards, click "Rescan" in the Syncthing UI.
set -euo pipefail

docker logs syncthing 2>&1 \
  | grep "permission denied" \
  | sed 's/.*mkdir \(.*\): permission.*/\1/' \
  | sort -u \
  | while read -r dir; do
      echo "creating: $dir"
      sudo mkdir -p "$dir"
    done
