# profile

export TERM='alacritty'
export PAGER='less'
export EDITOR='nvim'
export PATH=$PATH:~/.local/bin

## zsh
export ZDOTDIR=~/.config/zsh
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

## fcitx
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

## fzf
export FZF_DEFAULT_COMMAND='fd --type file --hidden'

## restic
export RESTIC_REPOSITORY=~/backup/restic_repo

## bat
export BAT_THEME='Nord'

## zk
export ZK_NOTEBOOK_DIR=~/note
