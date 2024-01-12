#!/bin/zsh

# # profiling zsh startup time
# zmodload zsh/zprof

# plugin manager (sheldon)
eval "$(sheldon source)"

# load starship
eval "$(starship init zsh)"

# load zstyles
[[ -f ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# load *.zsh file in .zsh.d
ZSHHOME="${ZDOTDIR}/.zsh.d"
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

# load zoxide
eval "$(zoxide init zsh)"

# load gh comp
# eval "$(gh completion -s zsh)"

# keybind
bindkey '^r' _select-history
bindkey '^z' _ctrl-z-fg
bindkey '^xe' edit-command-line
