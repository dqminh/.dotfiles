#!/bin/sh

killall -q xmobar &>/dev/null
while pgrep -x xmobar >/dev/null; do sleep 1; done
polybar top-external &
polybar top-laptop &

/run/current-system/sw/bin/xmobar /home/ajl/.xmobarrc
