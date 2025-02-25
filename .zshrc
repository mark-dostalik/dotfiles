# oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(
    vi-mode
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases
source $HOME/.work_aliases

CASE_SENSITIVE="true"  # case-sensitive completion
setopt NO_BEEP NO_AUTOLIST BASH_AUTOLIST NO_AUTO_MENU  # enable bash-like tab-completion

# make tab-completion show hidden files and folders
compinit
_comp_options+=(globdots)

prompt_context(){}  # always hide the "user@hostname" info on the local machine
export LANG=en_US.UTF-8  # manually set your language environment

# bash-like output of time command
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# vim in terminal set-up
export VI_MODE_SET_CURSOR=true  # set cursor to line instead of block in insert mode
export MODE_INDICATOR=""

# mcfly set-up
eval "$(mcfly init zsh)"
export MCFLY_KEY_SCHEME=vim  # use vim key scheme in McFly (enhancement of CTRL + r)

# accept zsh-autosuggestion by pressing CTRL + space
bindkey '^ ' autosuggest-accept
