# aliases

alias q='exit'
alias v='$PAGER'
alias e='$EDITOR'
alias cp='cp -i'
alias mv='mv -i'
alias cal='cal -y'

alias -g V='| $PAGER'
alias -g C='| xclip -sel c'

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

