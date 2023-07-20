## alias
alias _='sudo'
alias q='exit'
alias v='$PAGER'
alias e='$EDITOR'
alias cp='cp -i'
alias mv='mv -i'
alias cal='cal -Y'

alias -g VI='|_vipe'
alias j='_fg-fzf'

# global alias
alias -g V='|$PAGER'
alias -g C='|xsel -bi'

if [ $(which exa) &> /dev/null ]; then
  alias l='exa'
  alias ls='exa'
  alias sl='exa'
  alias la='exa -a'
  alias ll='exa -l'
  alias lla='exa -al'
  alias lal='exa -al'
else
  alias l='ls'
  alias sl='ls'
  alias la='ls -a'
  alias ll='ls -l'
  alias lal='ls -al'
  alias lla='ls -al'
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
  alias f='_lfcd'
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
  alias atn='at -f ~/bin/timer_notify.sh'
  alias atd='at -d $(at -l | fzf | cut -f 1)'
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
alias falias="alias | fzf | sed -e 's/^.*=//;s/^.\{1\}//;s/.\{1\}$//' | xsel -bi"
