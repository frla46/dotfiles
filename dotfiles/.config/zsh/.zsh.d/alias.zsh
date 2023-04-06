## alias
alias _='sudo'
alias c='cd'
alias q='exit'
alias v='$PAGER'
alias e='$EDITOR'
alias ps='procs'
alias md='mkdir'
#alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias y='yay'
alias f='lf'

# global alias
alias -g rm='trash-put'
alias -g G='|rg --color=auto'
alias -g V='|$PAGER'
alias -g C='|xsel --clipboard --input'
alias -g VI='|_vipe'

# oneliner
alias sz='source ${ZDOTDIR:-~}/.zshrc'
alias precp='fc -lrn|head -n 1 C'
alias memo="$EDITOR ~/doc/org/memo.org"
alias dusort='du --max-depth=1 -h --apparent-size | sort -rh'
alias mozc_dic='/usr/lib/mozc/mozc_tool --mode=dictionary_tool'
alias mozc_adddic='/usr/lib/mozc/mozc_tool --mode=word_register_dialog'
alias pysvr='python -m http.server 8000'

# git
if [[ $(type git) ]]; then
  alias g='git'
fi

# fd
if [[ $(type fd) ]]; then
  alias find='fd'
fi

# rg
if [[ $(type rg) ]]; then
  alias grep='rg'
fi

# protonvpn
if [[ $(type protonvpn-cli) ]]; then
    alias vpn='protonvpn-cli'
    alias vpns='vpn status'
    alias vpnc='vpn c --cc NL'
    alias vpnd='vpn d'
fi

# exa
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

