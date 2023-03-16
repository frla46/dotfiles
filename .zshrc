### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})窶ｦ%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# zinit plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit load agkozak/zsh-z

# prompt
# pure
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure
PURE_CMD_MAX_EXEC_TIME=86400 #1day
zstyle :prompt:pure:path color blue
zstyle :prompt:pure:prompt:success color green
zstyle :prompt:pure:suspended_jobs color blue

# environment variable
export BROWSER='/bin/vivaldi-stable'
export TERM='alacritty'
export PAGER='/usr/bin/less'
export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export PATH=$PATH:/home/frla/.local/bin

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
alias vi='nvim'
alias vim='nvim'
alias fm='_ranger-cd'
alias ps='procs'
alias grep='rg'
#alias find='fd'
alias md='mkdir'
#alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias tmr='timer'

# global alias
alias -g rm='trash-put'
alias -g G='|rg --color=auto'
alias -g V='|$PAGER'
alias -g X='|xargs'
alias -g S='|sort -h'
alias -g Sr='|sort -rh'
alias -g C='|xsel --clipboard --input'
alias -g VI='|_vipe'
alias -g n='notify-send'

# oneliner
alias sz='source ~/.zshrc'
alias precp='fc -lrn|head -n 1 C'
alias fmt_spc="rename -a ' ' '_' ./*; rename -a '-' '_' ./*"
alias rempd='killall mpd; mpd'
alias memo="e ~/doc/memo.txt"
alias resenu='\ls -Fv1 | grep -v "/$" | sed s/\*$//g | cat -n | while read n f; do mv -n "${f}" "$(printf "%d" $n).${f#*.}"; done'
alias subresenu='fmt_spc; for d in $(\ls -F | grep /); do cd $d; pwd; resenu; cd ..; done'
alias wx='curl wttr.in'
alias dus='du --max-depth=1 -h --apparent-size | sort -rh'
alias dic='/usr/lib/mozc/mozc_tool --mode=dictionary_tool'
alias adddic='/usr/lib/mozc/mozc_tool --mode=word_register_dialog'
alias psvr='python -m http.server 8000'

# execute with option
alias feh='feh --quiet --auto-zoom --scale-down --fullscreen --borderless --draw-filename'

# git
if [[ $(type git) ]]; then
  alias g='git'
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

# z with fzf
function _fz() {
  local dir
  dir=$(z -l | sed 's/[0-9 ]*//' | fzf)
  cd "$dir"
}

# cd with fzf included hidden directory
function _fd() {
  local dir
  dir=$(fd -H | fzf) && cd "$dir"
}

# use c-z instead of fg
function _^z-fg () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N _^z-fg
bindkey '^z' _^z-fg

# fg with fzf
alias j='_fg-fzf'
function _fg-fzf() {
  local cnt job
  cnt=$(jobs | wc -l)
  if [[ cnt -eq 0 ]]; then
  elif [[ cnt -eq 1 ]]; then
    fg
  else
    job=$(jobs | fzf | sed -e 's/\[//; s/\].*//' )
    fg %$job
  fi
}

function _ranger-cd {
  # prevent ranger nest
  if [ -z "$RANGER_LEVEL" ]; then
    # automatic cd when ranger quitted
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
  else
    exit
  fi
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

# use vim as a pipe
function _vipe () {
  COMMAND=$(echo "$*")
  \vim - -es +"norm gg$COMMAND" +'%p|q!' |sed '1d'
}

# download .mp4 video with aria2
alias ariav='_aria-mp4'
function _aria-mp4() {
  sed -e '/^$/d; /^http/!s/\(.\{80\}\)\(.*\)$/\1/; /^http/!s/^/ out=/; /^http/!s/$/.mp4/; /^http/!s/\// /g' $1 >| /tmp/aria-ed.list
  aria2c -i /tmp/aria-ed.list
}

# disable "crontab -r"
function crontab () {
  if [ "$1" = "-r" ]; then
    echo "crontab: disabled '-r' option";
  else
    command crontab "$@";
  fi
}
