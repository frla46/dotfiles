# variables

export TERM='alacritty'
export PAGER='less'
export EDITOR='nvim'
export BROWSER='vivaldi-stable'
export PATH=$PATH:~/.local/bin:~/.cargo/bin/:~/bin/

# zsh
export ZDOTDIR=~/.config/zsh
export HISTFILE=~/backup/files/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# fcitx
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

# restic
export RESTIC_REPOSITORY=~/backup/restic_repo
export RESTIC_PASSWORD_FILE=~/backup/files/restic_passwd.txt

## bat
export BAT_THEME='Nord'

# rg
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc

# pfetch
export PF_INFO='ascii title os wm shell editor'

# # go
# export GOPATH=~/src/go
# export GOBIN=~/src/go/bin
# export PATH=$PATH:$GOBIN:~/.local/bin
