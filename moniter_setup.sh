#!/usr/bin/env zsh

if xrandr | grep "HDMI-1 connected"; then
    xrandr --output HDMI-A-0 --primary --mode 3440x1440 --pos 0x0 --output eDP --mode 1920x1200 --left-of HDMI-A-0
else
    xrandr --output eDP --primary --mode 1920x1200 --pos 0x0
fi
