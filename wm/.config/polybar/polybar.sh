#!/bin/sh

killall -q polybar &>/dev/null
while pgrep -x polybar >/dev/null; do sleep 1; done
polybar top-external &
polybar top-laptop &
