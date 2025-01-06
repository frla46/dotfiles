#!/bin/zsh

# # profiling zsh startup time
# zmodload zsh/zprof

# plugin manager (sheldon)
eval "$(sheldon source)"

# load starship
eval "$(starship init zsh)"

# # completions (If enabled, startup will be slow)
# autoload -Uz compinit
# compinit
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
