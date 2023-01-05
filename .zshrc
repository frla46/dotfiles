# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# environment variable
export BROWSER='/bin/vivaldi-stable'
export TERM='alacritty'
export PAGER='/bin/bat'
export EDITOR='/bin/nvim'
export VISUAL='/bin/nvim'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

## options
compinit
promptinit
autoload -U compinit promptinit
setopt nocorrect
setopt IGNOREEOF
setopt auto_cd
unsetopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history
setopt hist_ignore_dups
setopt append_history

# emacs bind key
bindkey -d #reset keybind
bindkey -e #emacs mode


## alias
alias ..='cd ..'
alias /='cd /'
alias ~='cd ~'
alias c='cd'
alias p='pwd'
alias x='exit'
alias q='quit'
alias v='$PAGER'
alias e='$EDITOR'
alias grep='rg'
alias vi='nvim'
alias vim='nvim'
alias em='emacs'
alias fm='_ranger-cd'
alias ps='procs'
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=aunpack

# global alias
alias -g rm='trash-put'
alias -g G='|rg --color=auto'
alias -g V='|$PAGER'
alias -g X='|xargs'
alias -g S='|sort -h'
alias -g Sr='|sort -rh'
alias -g C='|xsel --clipboard --input'
alias -g N='|aplay ~/Music/notify.wav'

# oneliner
alias prev_cp='fc -lrn|head -n 1 C '
alias prev_add_snippet='fc -lrn|head -n 1 >> ~/.snippets'
alias du_sort='du --max-depth=1 -h --apparent-size | sort -rh'
alias duff_del='duff -re0 ./* | xargs -0 rm'
alias rename_seq_num='tmpdir=$(mktemp -d); i=1; for f in $(\ls -vF | grep -v / | sed s/\*$//g); do mv $f $tmpdir/$i.${f##*.}; i=`expr $i + 1`; done; mv $tmpdir/* ./'
alias replace_space="rename ' ' '_' ./*; rename '-' '_' ./*"
alias aria='~/bin/aria2v.sh'
alias ariased="sed -e '/^http/!s/^/ out=/; /^http/!s/$/.mp4/; /^http/!s/\// /'"

# startup option
alias vivaldi='vivaldi-stable --enable-features=WebUIDarkMode --force-dark-mode'
alias feh='feh --quiet --auto-zoom --scale-down --fullscreen --borderless --draw-filename'
alias mpv='mpv --no-input-default-bindings --no-terminal'

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

# dotbare
if [[ $(type dotbare) ]]; then
    alias dots='dotbare'
    alias dotsa='dots fadd'
    alias dotsaf='dots fadd -f'
    alias dotsad='dots fadd -d'
    alias dotse='dots fedit'
    alias dotsu='dots funtrack'
    alias dotsr='dots freset'
    alias dotss='dots fstat'
    alias dotsc='dots commit -m'
    alias dotsp='dots push'
fi

# exa
if [[ $(type exa) ]]; then
  alias exa='exa --icons'
  alias ls='exa'
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

# edit file with fzf
function _fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# z with fzf
function _fz() {
    local res=$(z | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}
zle -N _fz
bindkey '^g' _fz

# cd with fzf included hidden directory
function _fd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# use c-z instead of fg
function _c-z_nofg () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N _c-z_nofg
bindkey '^z' _c-z_nofg

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

# copy text in terminal
function _cp {
  echo $1 | xsel --clipboard --input
}

# kill with fzf
function _fkill() {
  local pid
  pid=$(\ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# use vim as a pipe
vipe () {
  COMMAND=$(echo "$*")
  \vim - -es +"norm gg$COMMAND" +'%p|q!' |sed '1d'
}

