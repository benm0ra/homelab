#!/usr/bin/env bash
# Hourly root-disk check. Logs a warning to journald when usage crosses a threshold.
# Install:  (crontab -l 2>/dev/null; echo "0 * * * * $HOME/homelab/scripts/disk-check.sh") | crontab -
# Review:   sudo journalctl -t disk-check
set -euo pipefail

THRESHOLD="${THRESHOLD:-80}"
USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "WARNING: root disk is ${USAGE}% full (threshold ${THRESHOLD}%)" | logger -t disk-check
fi
