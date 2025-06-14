#!/bin/bash

set -euo pipefail

if [[ $# -ne 1 || "$1" != @(0|1) ]]; then
    echo -e "Usage: $0 <0|1>  # 0 to disable boost, 1 to enable\n" >&2
    # Check state
    cpupower frequency-info
    exit 0
fi

STATE="$1"

for cpu_path in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/boost; do
    if [[ -f "$cpu_path" ]]; then
        echo "$STATE" | sudo tee "$cpu_path" > /dev/null
    else
        echo "Missing: $cpu_path" >&2
    fi
done