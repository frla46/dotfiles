#!/bin/sh

set -eu

STATE_FILE="${HOME}/.cache/redshift_state"
LATLON="36:140"

DEFAULT_BRIGHT_DAY=0.7
DEFAULT_BRIGHT_NIGHT=0.5
DEFAULT_TEMP_DAY=5000
DEFAULT_TEMP_NIGHT=2500

BRIGHT_MIN=0.10
BRIGHT_MAX=1.00

TEMP_MIN=1000
TEMP_MAX=25000

usage() {
  cat <<EOF
Usage:
  $0 init
  $0 bright-up <step>
  $0 bright-down <step>
  $0 temp-up <step>
  $0 temp-down <step>
EOF
}

init_state() {
  mkdir -p "$(dirname "$STATE_FILE")"

  cat >"$STATE_FILE" <<EOF
BRIGHT_DAY=$DEFAULT_BRIGHT_DAY
BRIGHT_NIGHT=$DEFAULT_BRIGHT_NIGHT
TEMP_DAY=$DEFAULT_TEMP_DAY
TEMP_NIGHT=$DEFAULT_TEMP_NIGHT
EOF
}

clamp_brightness() {
  value=$1

  awk "BEGIN {
    v=$value
    if (v < $BRIGHT_MIN) v=$BRIGHT_MIN
    if (v > $BRIGHT_MAX) v=$BRIGHT_MAX
    printf \"%.2f\", v
  }"
}

clamp_temperature() {
  value=$1

  if [ "$value" -lt "$TEMP_MIN" ]; then
    echo "$TEMP_MIN"
  elif [ "$value" -gt "$TEMP_MAX" ]; then
    echo "$TEMP_MAX"
  else
    echo "$value"
  fi
}

ACTION=${1-}
STEP_ARG=${2-}

case "$ACTION" in
init)
  ;;
bright-up | bright-down | temp-up | temp-down)
  if [ -z "$STEP_ARG" ]; then
    echo "Error: step value is required for $ACTION" >&2
    usage >&2
    exit 1
  fi
  STEP=$STEP_ARG
  ;;
-h | --help | help)
  usage
  exit 0
  ;;
*)
  usage >&2
  exit 1
  ;;
esac

if [ "$ACTION" = "init" ]; then
  init_state
else
  if [ ! -f "$STATE_FILE" ]; then
    init_state
  fi
  . "$STATE_FILE"
fi

case "$ACTION" in
init)
  BRIGHT_DAY=$DEFAULT_BRIGHT_DAY
  BRIGHT_NIGHT=$DEFAULT_BRIGHT_NIGHT
  TEMP_DAY=$DEFAULT_TEMP_DAY
  TEMP_NIGHT=$DEFAULT_TEMP_NIGHT
  ;;
bright-up)
  BRIGHT_DAY=$(awk "BEGIN{printf \"%.2f\", $BRIGHT_DAY + $STEP}")
  BRIGHT_NIGHT=$(awk "BEGIN{printf \"%.2f\", $BRIGHT_NIGHT + $STEP}")
  ;;
bright-down)
  BRIGHT_DAY=$(awk "BEGIN{printf \"%.2f\", $BRIGHT_DAY - $STEP}")
  BRIGHT_NIGHT=$(awk "BEGIN{printf \"%.2f\", $BRIGHT_NIGHT - $STEP}")
  ;;
temp-up)
  TEMP_DAY=$((TEMP_DAY + STEP))
  TEMP_NIGHT=$((TEMP_NIGHT + STEP))
  ;;
temp-down)
  TEMP_DAY=$((TEMP_DAY - STEP))
  TEMP_NIGHT=$((TEMP_NIGHT - STEP))
  ;;
esac

BRIGHT_DAY=$(clamp_brightness "$BRIGHT_DAY")
BRIGHT_NIGHT=$(clamp_brightness "$BRIGHT_NIGHT")

TEMP_DAY=$(clamp_temperature "$TEMP_DAY")
TEMP_NIGHT=$(clamp_temperature "$TEMP_NIGHT")

cat >"$STATE_FILE" <<EOF
BRIGHT_DAY=$BRIGHT_DAY
BRIGHT_NIGHT=$BRIGHT_NIGHT
TEMP_DAY=$TEMP_DAY
TEMP_NIGHT=$TEMP_NIGHT
EOF

if pgrep -x redshift >/dev/null 2>&1; then
  pkill -x redshift
fi

redshift \
  -b "$BRIGHT_DAY:$BRIGHT_NIGHT" \
  -t "$TEMP_DAY:$TEMP_NIGHT" \
  -l "$LATLON" \
  -r &

notify-send \
  -r 9999 \
  "Redshift" \
  "Brightness: ${BRIGHT_DAY}/${BRIGHT_NIGHT} \
  Temperature: ${TEMP_DAY}K/${TEMP_NIGHT}K"
