#!/bin/zsh

# zmodload zsh/zprof # profiling zsh startup time
# autoload -Uz compinit && compinit # completions

eval "$(sheldon source)" # sheldon
eval "$(starship init zsh)" # starship
eval "$(zoxide init zsh)" # zoxide

# eval "$(uv generate-shell-completion zsh)" # uv
# eval "$(gh completion -s zsh)" # gh

# load *.zsh file in .zsh.d
ZSHHOME="${ZDOTDIR}/.zsh.d"
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

# keybind
bindkey '^r' _select-history
bindkey '^z' _ctrl-z-fg
bindkey '^xe' edit-command-line
bindkey '^L' _my-clear
