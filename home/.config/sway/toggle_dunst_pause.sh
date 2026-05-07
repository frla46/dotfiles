#!/usr/bin/env zsh

paused=$(dunstctl is-paused)
if [[ "$paused" = true ]]; then
  dunstctl set-paused false
  notify-send "enable notification"
else
  dunstctl set-paused true
fi
