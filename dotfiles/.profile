# profile

export BROWSER=vivaldi-stable
export TERM=alacritty
export TERMINAL=alacritty
export PAGER=less
export EDITOR=nvim
export VISUAL=nvim

# zsh
export ZDOTDIR=~/.config/zsh
export HISTFILE=${ZDOTDIR:-~}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export PATH=$PATH:/home/frla/.local/bin

# fcitx
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --hidden'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# bat
export BAT_THEME="Nord"
