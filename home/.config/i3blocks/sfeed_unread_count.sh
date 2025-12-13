#!/usr/bin/env sh

SFEED_DIR="$HOME/.local/share/sfeed"
UNREAD_FILE="$SFEED_DIR/unread"

if [ -f "$UNREAD_FILE" ]; then
  count=$(wc -l <"$UNREAD_FILE")
else
  count=0
fi

echo "󰑫 $count "
