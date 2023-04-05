#!/bin/zsh

# antidote
source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

# prompt
autoload -Uz promptinit && promptinit && prompt pure
PURE_CMD_MAX_EXEC_TIME=86400 #1day

# load zstyles
[[ -f ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# # zinit plugins
# zinit light zsh-users/zsh-syntax-highlighting
# zinit light zsh-users/zsh-autosuggestions
# zinit light zsh-users/zsh-completions
# zinit load agkozak/zsh-z

## options
setopt IGNOREEOF
setopt append_history
setopt auto_cd
setopt correct
setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt no_beep
setopt no_flow_control
setopt nocorrect
setopt share_history
unset LESSEDIT
unsetopt share_history

# emacs bind key
bindkey -d #reset keybind
bindkey -e #emacs mode


## alias
alias _='sudo'
alias c='cd'
alias q='exit'
alias v='$PAGER'
alias e='$EDITOR'
alias ps='procs'
alias md='mkdir'
#alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias y='yay'

# global alias
alias -g rm='trash-put'
alias -g G='|rg --color=auto'
alias -g V='|$PAGER'
alias -g C='|xsel --clipboard --input'
alias -g VI='|_vipe'

# oneliner
alias sz='source ${ZDOTDIR:-~}/.zshrc'
alias precp='fc -lrn|head -n 1 C'
alias memo="e ~/doc/memo.txt"
alias dusort='du --max-depth=1 -h --apparent-size | sort -rh'
alias mozc_dic='/usr/lib/mozc/mozc_tool --mode=dictionary_tool'
alias mozc_adddic='/usr/lib/mozc/mozc_tool --mode=word_register_dialog'
alias pysvr='python -m http.server 8000'

# git
if [[ $(type git) ]]; then
  alias g='git'
fi

# fd
if [[ $(type fd) ]]; then
  alias find='fd'
fi

# rg
if [[ $(type rg) ]]; then
  alias grep='rg'
fi

# protonvpn
if [[ $(type protonvpn-cli) ]]; then
    alias vpn='protonvpn-cli'
    alias vpns='vpn status'
    alias vpnc='vpn c --cc NL'
    alias vpnd='vpn d'
fi

# exa
if [[ $(type exa) ]]; then
  alias exa='exa --icons'
  alias l='exa'
  alias ls='exa'
  alias sl='exa'
  alias la='exa -a'
  alias ll='exa -l'
  alias lla='exa -a -l'
  alias lal='exa -a -l'
fi


## function
# fzf history
function _select-history() {
  BUFFER=$(history -n -r 1 | fzf --exact --reverse --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
}
zle -N _select-history
bindkey '^r' _select-history

# open file in editor with fzf
function _fe() {
  local file
  file=$(fd --type file -H | fzf) && $EDITOR "$file"
}

# z with fzf
function _fz() {
  local dir
  dir=$(z -l | sed 's/[0-9 ]*//' | fzf) && cd "$dir"
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
alias j='_fg-fzf'
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
bindkey '^z' _ctrl-z-fg

# prevent instance nested in lf
function lf() {
  [ -n "$LF_LEVEL" ] && exit || command lf "$@"
}

# use vim as a pipe
function _vipe () {
  COMMAND=$(echo "$*")
  \vim - -es +"norm gg$COMMAND" +'%p|q!' |sed '1d'
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
alias ariav='_aria-mp4'
function _aria-mp4() {
  sed -e '/^$/d; /^http/!s/\(.\{80\}\)\(.*\)$/\1/; /^http/!s/^/ out=/; /^http/!s/$/.mp4/; /^http/!s/\// /g' $1 >| /tmp/aria-ed.list
  aria2c -i /tmp/aria-ed.list -UWget
}
