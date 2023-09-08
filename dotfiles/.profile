# variables
export TERM='alacritty'
export PAGER='less'
export EDITOR='nvim'
export BROWSER='vivaldi-stable'
export PATH=$PATH:~/.local/bin
# export GOPATH=~/src/go
# export GOBIN=~/src/go/bin
# export PATH=$PATH:$GOBIN:~/.local/bin

# zsh
export ZDOTDIR=~/.config/zsh
export HISTFILE=~/backup/files/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# fcitx
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --hidden'

# restic
export RESTIC_REPOSITORY=~/backup/restic_repo
export RESTIC_PASSWORD_FILE=~/backup/files/restic_passwd.txt

## bat
export BAT_THEME='Nord'

# zk
export ZK_NOTEBOOK_DIR=~/backup/note/

# ssh
if [ $(pgrep -c ssh-agent) -eq 0 ]; then
	eval $(ssh-agent)
fi
