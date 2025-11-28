# environment variables

export TERM='wezterm'
export PAGER='less'
export EDITOR='nvim'
export BROWSER='zen-browser'
export PATH=$PATH:~/.local/bin/:~/.cargo/bin/:~/bin/

## zsh
export ZDOTDIR=~/.config/zsh
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

## fcitx
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

## restic
export RESTIC_REPOSITORY=/mnt/E/C/
export RESTIC_PASSWORD_FILE=~/sync/bak/restic_passwd.txt

## bat
export BAT_THEME='Nord'

## rg
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc

## pfetch
export PF_INFO='ascii title os wm shell editor'

## go
export GOPATH=~/src/go
export GOBIN=~/src/go/bin
export PATH=$PATH:$GOBIN

## ani-cli
export ANI_CLI_DOWNLOAD_DIR=~/dl/
