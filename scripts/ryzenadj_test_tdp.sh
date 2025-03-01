#!/bin/bash

# Target maximum temperature (+5)
TARGET_TEMP=85
# Starting TDP in watts (based on your current usage)
CURRENT_TDP=25
# Min TDP limit (watts)
MIN_TDP=15
# TDP adjustment step (watts)
TDP_STEP=5

echo "=== TDP Optimization Script ==="
echo "Finding maximum TDP while keeping temperature below ${TARGET_TEMP}°C"

while true; do
    # Apply current TDP
    TDP_MW=$(echo "$CURRENT_TDP * 1000 / 1" | bc)
    echo "Setting TDP to ${CURRENT_TDP}W..."
    sudo ryzenadj --stapm-limit="$TDP_MW" --fast-limit="$TDP_MW" --slow-limit="$TDP_MW"

    # Run stress test for 30 seconds
    echo "Running stress test..."
    stress-ng --cpu "$(nproc)" --cpu-method matrixprod --timeout 30s &
    STRESS_PID=$!

    # Monitor temperature during stress test
    MAX_TEMP=0
    while kill -0 $STRESS_PID 2>/dev/null; do
        # Get current CPU temperature
        CURRENT_TEMP=$(cat /sys/class/hwmon/hwmon*/temp1_input 2>/dev/null | sort -r | head -n1 | awk '{print $1/1000}')

        if (( $(echo "$CURRENT_TEMP > $MAX_TEMP" | bc -l) )); then
            MAX_TEMP=$CURRENT_TEMP
        fi

        echo -ne "Current temp: ${CURRENT_TEMP}°C, Max temp: ${MAX_TEMP}°C\r"
        sleep 1
    done
    echo -e "\nStress test completed. Maximum temperature: ${MAX_TEMP}°C"

    # Decision logic
    if (( $(echo "$MAX_TEMP > $TARGET_TEMP" | bc -l) )); then
        echo "Temperature exceeded target. Reducing TDP."
        CURRENT_TDP=$(echo "$CURRENT_TDP - $TDP_STEP" | bc -l)

        if (( $(echo "$CURRENT_TDP < $MIN_TDP" | bc -l) )); then
            CURRENT_TDP=$MIN_TDP
            echo "Reached minimum safe TDP of ${MIN_TDP}W."
            echo "Recommended TDP: ${CURRENT_TDP}W"
            break
        fi
    elif (( $(echo "$MAX_TEMP < ($TARGET_TEMP - 5)" | bc -l) )); then
        echo "Temperature well below target. Increasing TDP."
        CURRENT_TDP=$(echo "$CURRENT_TDP + $TDP_STEP" | bc -l)
    else
        echo "Found optimal TDP: ${CURRENT_TDP}W (Max temp: ${MAX_TEMP}°C)"
        break
    fi

    # Cool down period between tests
    echo "Cooling down for 10 seconds..."
    sleep 10
done
