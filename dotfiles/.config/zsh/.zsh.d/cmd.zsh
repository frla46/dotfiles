## alias
alias _='sudo'
alias q='exit'
alias c='clear'
alias v='$PAGER'
alias e='$EDITOR'
alias cp='cp -i'
alias mv='mv -i'
alias cal='cal -y'
alias -g V='|$PAGER'
alias -g C='|xsel -bi'
alias -g VI='|_vipe'

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
  alias lal='ls -al'
  alias lla='ls -al'
fi

if [ $(which tmux) &> /dev/null ]; then
  alias t='tmux'
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
  alias cat='bat -p'
fi

if [ $(which trash-put) &> /dev/null ]; then
  alias -g rm='trash-put'
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
  alias dcp='docker ps -a | sed "1d" | fzf -m | awk "{print $1}" | xsel -bi'
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
  alias vpnc='protonvpn-cli c --cc NL'
  alias vpnd='protonvpn-cli d'
fi

if [ $(which at) &> /dev/null ]; then
  alias atl='at -l'
  alias atd='at -d $(at -l | fzf | cut -f 1)'
  function atn(){
    at $1 -f <(echo "notify-send $*")
  }
fi

if [ $(which restic) &> /dev/null ]; then
  alias restic_backup='restic --exclude-file ~/.resticignore backup ~'
  alias restic_delete='restic forget $(restic snapshots | rg "^\w{8}\s" | fzf | cut -d " " -f 1)'
  alias restic_mount='sudo mkdir -p /mnt/restic && restic mount /mnt/restic'
  alias restic_clean='restic forget -l 5 && restic prune'
fi

# misc
alias sz='source ${ZDOTDIR:-~}/.zshrc'
alias hcp='fc -lnr | fzf | xsel -bi'
alias mozc_dic='/usr/lib/mozc/mozc_tool --mode=dictionary_tool'
alias mozc_add='/usr/lib/mozc/mozc_tool --mode=word_register_dialog'
alias mpv='mpv --no-terminal'

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

# kill with click
function _ck() {
  local pid
  pid=$(xprop | sed -e '/_NET_WM_PID(CARDINAL) = /!d; s/_NET_WM_PID(CARDINAL) = //')
  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fg with fzf
function _fg-fzf() {
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

# use vim as a pipe
function _vipe () {
  COMMAND=$(echo "$*")
  \vim - -es +"$COMMAND" +'%p' +'q!' | sed '1d'
}

# disable "crontab -r"
function crontab () {
  if [ "$1" = "-r" ]
  then
    echo "crontab: disabled '-r' option";
  else
    command crontab "$@";
  fi
}

# notify when task finished
function _n() {
  $*
  if [ $? -eq 0 ]; then
    notify-send -u normal "task finished." "$*"
  else
    notify-send -u critical "error occurred." "$*"
  fi
}

# edit current command with EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
