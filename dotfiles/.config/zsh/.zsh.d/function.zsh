## function
# fzf history
function _select-history() {
  BUFFER=$(history -n -r 1 | fzf --exact --reverse --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
}
zle -N _select-history

# open file in editor with fzf
function _fe() {
  local file
  file=$(fd --type file -H | fzf) && $EDITOR "$file"
}

# cd with fzf included hidden directory
function _fd() {
  local dir
  dir=$(fd --type d -H | fzf) && cd "$dir"
}

# kill with fzf
function _fk() {
  local pid
  pid=$(\ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fg with fzf
function _fg-fzf() {
  local cnt job
  cnt=$(jobs | wc -l)
  if [[ "$cnt" -eq 0 ]]; then
  elif [[ "$cnt" -eq 1 ]]; then
    fg
  else
    job=$(jobs | fzf | sed -e 's/\[//; s/\].*//' )
    fg %"$job"
  fi
}

# use c-z instead of fg
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

# cd when quittng lf
function _lfcd () {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
      fi
    fi
  fi
}

# # prevent instance nested in lf
# function lf() {
#   [ -n "$LF_LEVEL" ] && exit || command lf "$@"
# }

# use vim as a pipe
function _vipe () {
  COMMAND=$(echo "$*")
  \vim - -es +"$COMMAND" +'%p' +'q!' | sed '1d'

}

# disable "crontab -r"
function crontab () {
  if [ "$1" = "-r" ]; then
    echo "crontab: disabled '-r' option";
  else
    command crontab "$@";
  fi
}

# download mp4 video with aria2
function _aria-mp4() {
  sed -e '/^$/d; /^http/!s/\(.\{80\}\)\(.*\)$/\1/; /^http/!s/^/ out=/; /^http/!s/$/.mp4/; /^http/!s/\// /g' $1 >| /tmp/aria-ed.list
  aria2c -i /tmp/aria-ed.list -UWget
}

# edit current command with EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
