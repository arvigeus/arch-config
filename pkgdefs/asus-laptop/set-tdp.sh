#!/usr/bin/env bash
set -euo pipefail

# Root check
[[ $EUID -ne 0 ]] && { echo "Root is required"; exit 1; }

# Arg check
[[ $# -ne 1 || ! "$1" =~ ^[0-9]+$ ]] && { echo "Usage: $0 <TDP in watts>"; exit 1; }

TDP="$1"
MIN_TDP=12

# Get max from slow_limit
SLOW_LIMIT_MW=$(ryzenadj -i | awk '/slow_limit/ { print $2 }')
[[ -z "$SLOW_LIMIT_MW" || "$SLOW_LIMIT_MW" -le 0 ]] && { echo "Failed to read slow_limit"; exit 1; }
MAX_TDP=$(( SLOW_LIMIT_MW / 1000 ))

# Range check
(( TDP < MIN_TDP || TDP > MAX_TDP )) && {
  echo "TDP must be between ${MIN_TDP}W and ${MAX_TDP}W"; exit 1;
}

# Apply
TDP_MW=$(( TDP * 1000 ))
ryzenadj --stapm-limit="$TDP_MW" --fast-limit="$TDP_MW" --slow-limit="$TDP_MW"
echo "Set TDP to ${TDP}W"