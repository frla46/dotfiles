#!/usr/bin/env sh

BAT=/sys/class/power_supply/BAT0

capacity=$(cat "$BAT/capacity")
status=$(cat "$BAT/status")

case "$status" in
Charging)
  icon=""
  ;;
Discharging)
  if [ "$capacity" -le 11 ]; then
    icon=""
  else
    icon=""
  fi
  ;;
Full)
  icon=""
  ;;
*)
  icon=""
  ;;
esac

echo "$icon $capacity% "
