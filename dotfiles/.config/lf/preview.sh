#!/usr/bin/env bash

file=$1
w=$2
h=$3
x=$4
y=$5

filetype="$(file -Lb --mime-type "$file")"

if [[ "$filetype" =~ ^text ]] ||
  [[ "$filetype" =~ application/javascript ]]; then
  if [ $(which bat) ] &>/dev/null; then
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
  exit 1
fi

if [[ "$filetype" =~ application/json ]]; then
  if [ $(which jq) ] &>/dev/null; then
    jq -C . <"$file"
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
  exit 1
fi

if [[ "$filetype" =~ ^image ]]; then
  chafa -f sixel -s "$2x$3" --animate off --polite on "$file"
  exit 1
fi

if [[ "$filetype" =~ ^video ]] ||
  [[ "$filetype" =~ ^audio ]]; then
  chafa -f sixel -s "$2x$3" --animate off --polite on "$(~/.config/lf/vidthumb.sh "$file")"
  exit 1
fi

# ctpv "$file"
