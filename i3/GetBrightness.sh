#!/usr/bin/env zsh

brightness_eDP_raw=$(xrandr --verbose | grep -i 'eDP' -A5 | grep 'Brightness:' | awk '{print $2}')
brightness_eDP=$(printf "%.0f" $(echo "$brightness_eDP_raw * 100" | bc))

if [ "$brightness_eDP_raw" = "1" ]; then
    brightness_eDP=100
fi

if [ -n "$brightness_eDP" ]; then
    echo "eDP: $brightness_eDP%"
else
    echo "N/A"
fi
