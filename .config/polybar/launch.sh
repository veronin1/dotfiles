#!/usr/bin/env bash

polybar-msg cmd quit
killall polybar

# Wait for polybar processes to fully exit
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar top &

