# oh-my-zsh configuration
ZSH_THEME=""
plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $HOME/.oh-my-zsh/oh-my-zsh.sh

# aliases
source $HOME/.zsh_aliases
source $HOME/.work_aliases

# pure prompt
autoload -U promptinit; promptinit
prompt pure

CASE_SENSITIVE="true"  # case-sensitive completion
setopt NO_BEEP NO_AUTOLIST BASH_AUTOLIST NO_AUTO_MENU  # enable bash-like tab-completion

# make tab-completion show hidden files and folders
compinit
_comp_options+=(globdots)

# bash-like output of time command
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# vim in terminal set-up
bindkey -v
KEYTIMEOUT=1  # make switching between modes faster

function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
        echo -ne "\e[2 q"  # block cursor
    else
        echo -ne "\e[5 q"  # bar cursor
    fi
}
zle -N zle-keymap-select
function zle-line-init {
    echo -ne "\e[5 q"  # start bar cursor
}
zle -N zle-line-init
function zle-line-finish {
    echo -ne "\e[2 q"  # restore block cursor
}
zle -N zle-line-finish
precmd_functions+=(zle-keymap-select)

# enable vim selections within quoted strings
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

# mcfly set-up
eval "$(mcfly init zsh)"
export MCFLY_KEY_SCHEME=vim  # use vim key scheme in McFly (enhancement of CTRL + r)

# accept zsh-autosuggestion by pressing CTRL + space
bindkey '^ ' autosuggest-accept
