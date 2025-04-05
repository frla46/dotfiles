#!/usr/bin/env bash

file=$1
w=$2
h=$3
x=$4
y=$5

filetype="$(file -Lb --mime-type "$file")"

if [[ "$filetype" =~ ^image ]]; then
  chafa -f sixel --animate off --polite on "$file"
  exit 1
elif [[ "$filetype" =~ ^audio ]] ||
  [[ "$filetype" =~ ^video ]]; then
  chafa -f sixel --animate off --polite on "$(~/.config/lf/vidthumb.sh "$file")"
  exit 1
elif [ $(which bat) ] &>/dev/null; then
  bat \
    --color always \
    --style plain \
    -- paging never \
    --terminal-width "$w" \
    --wrap character \
    -- "$file"
else
  cat "$file"
fi
