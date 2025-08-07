#!/bin/bash

# Get battery capacities
BAT0_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
BAT1_CAPACITY=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)

# Get battery statuses
BAT0_STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
BAT1_STATUS=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null)

# Average battery percentage
if [[ -n "$BAT0_CAPACITY" && -n "$BAT1_CAPACITY" ]]; then
    AVG=$(( (BAT0_CAPACITY + BAT1_CAPACITY) / 2 ))
elif [[ -n "$BAT0_CAPACITY" ]]; then
    AVG=$BAT0_CAPACITY
elif [[ -n "$BAT1_CAPACITY" ]]; then
    AVG=$BAT1_CAPACITY
else
    AVG=0
fi

# Determine charging status
if [[ "$BAT0_STATUS" == "Charging" || "$BAT1_STATUS" == "Charging" ]]; then
    IS_CHARGING=true
else
    IS_CHARGING=false
fi

# Pick icon
if [ "$IS_CHARGING" = true ]; then
    ICON=""  # Charging icon
else
    if (( AVG >= 95 )); then
        ICON=""  # nf-fa-battery_4 / full
    elif (( AVG >= 75 )); then
        ICON=""  # nf-fa-battery_3
    elif (( AVG >= 50 )); then
        ICON=""  # nf-fa-battery_2
    elif (( AVG >= 25 )); then
        ICON=""  # nf-fa-battery_1
    else
        ICON=""  # nf-fa-battery_0 / empty
    fi
fi

# Output for polybar
echo "$ICON $AVG%"
