# functions

function _select-history() {
  BUFFER=$(history -n -r 1 | fzf --exact --reverse --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
}
zle -N _select-history

function _fe() {
  local file
  file=$(fd --type file -H | fzf) && $EDITOR "$file"
}

function _fd() {
  local dir
  dir=$(fd --type d -H | fzf) && cd "$dir"
}

function _fk() {
  local pid
  pid=$(\ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

function _ck() {
  local pid
  pid=$(xprop | sed -e '/_NET_WM_PID(CARDINAL) = /!d; s/_NET_WM_PID(CARDINAL) = //')
  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

function _fg() {
  local cnt job
  cnt=$(jobs | wc -l)
  if [[ "$cnt" -eq 0 ]]
  then
    :
  elif [[ "$cnt" -eq 1 ]]
  then
    fg
  else
    job=$(jobs | fzf | sed -e 's/\[//; s/\].*//' )
    fg %"$job"
  fi
}

function _ctrl-z-fg () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N _ctrl-z-fg

function _vipe () {
  COMMAND=$(echo "$*")
  \vim - -es +"$COMMAND" +'%p' +'q!' | sed '1d'
}

function crontab () {
  if [ "$1" = "-r" ]
  then
    echo "crontab: disabled '-r' option";
  else
    command crontab "$@";
  fi
}

function _n() {
  $*
  if [ $? -eq 0 ]; then
    notify-send -u normal "task finished." "$*"
  else
    notify-send -u critical "error occurred." "$*"
  fi
}

function countdown() {
    start="$(( $(date '+%s') + $1))"
    while [ $start -ge $(date +%s) ]; do
        time="$(( $start - $(date +%s) ))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
    notify-send $1
}

function stopwatch() {
    start=$(date +%s)
    while true; do
        time="$(( $(date +%s) - $start))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

function _my-clear() {
  for i in {3..$(tput lines)}
  do
    printf '\n'
  done
  printf '\33[H\33[2J'
  zle reset-prompt
}
zle -N _my-clear

autoload -Uz edit-command-line
zle -N edit-command-line
