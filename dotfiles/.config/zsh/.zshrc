#!/bin/zsh

# plugin manager (antidote)
# archlinux: pacman -S zsh-antidote
# git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
# source ${ZDOTDIR:-~}/.antidote/antidote.zsh
source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

# prompt
autoload -Uz promptinit && promptinit && prompt pure
PURE_CMD_MAX_EXEC_TIME=86400 #1day

# load zstyles
[[ -f ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# load *.zsh file in zsh.d
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
