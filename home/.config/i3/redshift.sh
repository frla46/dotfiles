#!/usr/bin/env bash
set -euo pipefail
set -x

STATE_FILE="$HOME/.cache/redshift_state"
LATLON="36:140"

# Default values
DEFAULT_BRIGHT_DAY=1.0
DEFAULT_BRIGHT_NIGHT=0.7
DEFAULT_TEMP_DAY=5000
DEFAULT_TEMP_NIGHT=2500

ACTION="${1:-}"
STEP_ARG="${2:-}"

# --------------------
# Initialize state file with default values
# --------------------
init_state() {
  cat >"$STATE_FILE" <<EOF
BRIGHT_DAY=$DEFAULT_BRIGHT_DAY
BRIGHT_NIGHT=$DEFAULT_BRIGHT_NIGHT
TEMP_DAY=$DEFAULT_TEMP_DAY
TEMP_NIGHT=$DEFAULT_TEMP_NIGHT
EOF
}

# --------------------
# Validate arguments
# --------------------
case "$ACTION" in
init) ;;
bright-up | bright-down | temp-up | temp-down)
  if [[ -z "$STEP_ARG" ]]; then
    echo "Error: step value is required for $ACTION"
    echo "Usage: $0 {bright-up|bright-down|temp-up|temp-down} <step>"
    exit 1
  fi
  STEP="$STEP_ARG"
  ;;
*)
  echo "Usage: $0 {init|bright-up|bright-down|temp-up|temp-down} <step>"
  exit 1
  ;;
esac

# --------------------
# Load or initialize state
# --------------------
if [[ "$ACTION" == "init" ]]; then
  init_state
else
  if [[ ! -f "$STATE_FILE" ]]; then
    init_state
  fi
  source "$STATE_FILE"
fi

# --------------------
# Handle actions
# --------------------
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

# --------------------
# Save state
# --------------------
cat >"$STATE_FILE" <<EOF
BRIGHT_DAY=$BRIGHT_DAY
BRIGHT_NIGHT=$BRIGHT_NIGHT
TEMP_DAY=$TEMP_DAY
TEMP_NIGHT=$TEMP_NIGHT
EOF

# --------------------
# Restart redshift
# --------------------
if pgrep -x redshift >/dev/null; then
  pkill -x redshift
fi

redshift -b "$BRIGHT_DAY:$BRIGHT_NIGHT" -t "$TEMP_DAY:$TEMP_NIGHT" -l "$LATLON" -r &
