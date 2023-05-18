## alias
alias _='sudo'
alias c='cd'
alias q='exit'
alias v='$PAGER'
alias e='$EDITOR'
alias cp='cp -i'
alias mv='mv -i'
alias cal='cal -Y'

# global alias
alias -g V='|$PAGER'
alias -g C='|xsel --clipboard --input'

# my function
alias -g VI='|_vipe'
alias j='_fg-fzf'
alias ariav='_aria-mp4'

if [ $(which yay) &> /dev/null ]; then
  alias y='yay'
  alias yy='yay --noconfirm --needed'
fi

if [ $(which lf) &> /dev/null ]; then
  alias f='_lfcd'
fi

if [ $(which trash-put) &> /dev/null ]; then
  alias -g rm='trash-put'
else
  alias rm='rm -i'
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

if [ $(which git) &> /dev/null ]; then
  alias g='git'
fi

if [ $(which lazygit) &> /dev/null ]; then
  alias lg='lazygit'
fi

if [ $(which protonvpn-cli) &> /dev/null ]; then
  alias vpn='protonvpn-cli'
  alias vpns='vpn status'
  alias vpnc='vpn c --cc NL'
  alias vpnd='vpn d'
fi

if [ $(which exa) &> /dev/null ]; then
  alias exa='exa --icons'
  alias l='exa'
  alias ls='exa'
  alias sl='exa'
  alias la='exa -a'
  alias ll='exa -l'
  alias lla='exa -a -l'
  alias lal='exa -a -l'
fi

if [ $(which at) &> /dev/null ]; then
  alias atl='at -l'
  alias atn='at -f ~/bin/timer_notify.sh'
  alias atd='at -d $(at -l | fzf | cut -f 1)'
fi

# misc
alias sz='source ${ZDOTDIR:-~}/.zshrc'
alias precp='fc -ln | tail -n 1 C'
alias mozc_dic='/usr/lib/mozc/mozc_tool --mode=dictionary_tool'
alias mozc_add='/usr/lib/mozc/mozc_tool --mode=word_register_dialog'
alias mpv='mpv --no-terminal'

