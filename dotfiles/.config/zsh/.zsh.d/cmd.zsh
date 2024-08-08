# alias

alias _='sudo'
alias q='exit'
alias c='clear'
alias v='$PAGER'
alias e='$EDITOR'
alias cp='cp -i'
alias mv='mv -i'
alias cal='cal -y'

alias -g V='| $PAGER'
alias -g C='| xclip -sel c'
alias -g VI='| _vipe'

alias sz='source ${ZDOTDIR:-~}/.zshrc'
alias eh='e $HISTFILE'
alias hcp='fc -lnr | fzf | xclip -sel c'

if [ $(which eza) &> /dev/null ]; then
  alias l='eza'
  alias ls='eza'
  alias sl='eza'
  alias la='eza -a'
  alias ll='eza -l'
  alias lla='eza -al'
  alias lal='eza -al'
else
  alias l='ls'
  alias sl='ls'
  alias la='ls -a'
  alias ll='ls -l'
  alias lla='ls -al'
  alias lal='ls -al'
fi

if [ $(which fd) &> /dev/null ]; then
  alias find='fd'
fi

if [ $(which rg) &> /dev/null ]; then
  alias grep='rg'
  alias -g G='|rg --color=auto'
else
  alias -g G='|grep --color=auto'
fi

if [ $(which procs) &> /dev/null ]; then
  alias ps='procs'
fi

if [ $(which bat) &> /dev/null ]; then
  alias bat='bat -p'
  alias cat='bat -p'
fi

if [ $(which conceal) &> /dev/null ]; then
  alias -g rm='cnc'
else
  alias rm='rm -i'
fi

if [ $(which dust) &> /dev/null ]; then
  alias du='dust'
fi

if [ $(which yay) &> /dev/null ]; then
  alias y='yay'
  alias yy='yay --noconfirm --needed'
  alias ya='yay -S $(yay -Ssq | fzf -m)'
  alias yya='yay --noconfirm -S $(yay -Ssq | fzf -m)'
  alias yr='yay -Rs $(yay -Qeq | fzf -m)'
  alias yc='yay --noconfirm -Yc && yay --noconfirm -Sc'
fi

if [ $(which lf) &> /dev/null ]; then
  alias f='lf'
fi

if [ $(which git) &> /dev/null ]; then
  alias g='git'
fi

if [ $(which lazygit) &> /dev/null ]; then
  alias lg='lazygit'
fi

if [ $(which docker) &> /dev/null ]; then
  alias d='docker'
  alias dcp='docker ps -a | sed "1d" | fzf -m | awk "{print $1}" | xclip -sel c'
  alias dps='docker ps'
  alias dpa='docker ps -a'
  alias dim='docker images'
  alias dr='docker run'
  alias dri='docker run -it'
  alias dei='docker exec -it'
  alias drm='docker rm $(docker ps -a | sed "1d" | fzf -m | awk "{print $1}")'
  alias drmi='docker rmi $(docker images | sed "1d" | fzf -m | awk "{print $1}")'
  alias dstop='docker stop $(docker ps -a | sed "1d" | fzf -m | awk "{print $1}")'
fi

if [ $(which lazydocker) &> /dev/null ]; then
  alias ld='lazydocker'
fi

if [ $(which protonvpn-cli) &> /dev/null ]; then
  alias vpn='protonvpn-cli'
  alias vpns='protonvpn-cli status'
  alias vpnc='protonvpn-cli c'
  alias vpnd='protonvpn-cli d'
fi

if [ $(which at) &> /dev/null ]; then
  alias atl='at -l'
  alias atd='at -d $(at -l | fzf -m | cut -f 1)'
  function atn(){
    at $1 -f <(echo "notify-send $*")
  }
fi

if [ $(which restic) &> /dev/null ]; then
  alias restic_backup='restic backup --exclude-file ~/.resticignore ~'
  alias restic_delete='restic forget $(restic snapshots | rg "^\w{8}\s" | fzf -m | cut -d " " -f 1)'
  alias restic_mount='sudo mkdir -p /mnt/restic && sudo chown $(whoami):$(whoami) /mnt/restic && restic mount /mnt/restic'
  alias restic_clean='restic forget -m 1 && restic prune'
fi

if [ $(which mpv) &> /dev/null ]; then
  alias mpv_audio='mpv --ytdl-format="worstvideo+bestaudio"'
  alias mpv_video='mpv --ytdl-format=bestvideo[height<=?720]+bestaudio/best'
fi

# function

function _select-history() {
  BUFFER=$(history -n -r 1 | fzf --exact --reverse --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
}
zle -N _select-history

function _fe() {
  local file
  file=$(fd --type file -H | sk) && $EDITOR "$file"
}

function _fd() {
  local dir
  dir=$(fd --type d -H | sk) && cd "$dir"
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

autoload -Uz edit-command-line
zle -N edit-command-line
