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
alias j='_fg-fzf'
alias ariav='_aria-mp4'
alias -g VI='|_vipe'

if [[ $(type yay) ]]; then
  alias y='yay'
  alias yy='yay --noconfirm --needed'
fi

if [[ $(type lf) ]]; then
  alias f='_lfcd'
fi

if [[ $(type trash-put) ]]; then
  alias -g rm='trash-put'
else
  alias rm='rm -i'
fi

if [[ $(type fd) ]]; then
  alias find='fd'
fi

if [[ $(type rg) ]]; then
  alias grep='rg'
  alias -g G='|rg --color=auto'
else
  alias -g G='|grep --color=auto'
fi

if [[ $(type procs) ]]; then
  alias ps='procs'
fi

if [[ $(type git) ]]; then
  alias g='git'
fi

if [[ $(type lazygit) ]]; then
  alias lg='lazygit'
fi

if [[ $(type protonvpn-cli) ]]; then
    alias vpn='protonvpn-cli'
    alias vpns='vpn status'
    alias vpnc='vpn c --cc NL'
    alias vpnd='vpn d'
fi

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

if [[ $(type at) ]]; then
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

