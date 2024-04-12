#!/usr/bin/env zsh

current_brightness1=$(xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' ')

new_brightness1=$(echo "$current_brightness1 + 0.10" | bc)

xrandr --output eDP --brightness $new_brightness1
