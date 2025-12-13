source $HOME/.zsh_aliases
source $HOME/.work_aliases

export PATH="$HOME/.local/bin:$PATH"
export JAVA_HOME=~/jdk-23.0.2.jdk/Contents/Home

# pure prompt
autoload -U promptinit; promptinit
prompt pure

# bash-like output of time command
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# vi mode
KEYTIMEOUT=1  # make switching between modes faster
bindkey -v
bindkey -M viins '^j' down-line-or-search
bindkey -M viins '^k' up-line-or-search
# bindkey -M viins '^l' vi-forward-word

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

# Ring bell if command took longer than 5 seconds
preexec() {
	    CMD_START_TIME=$EPOCHREALTIME
    }
precmd() {
	if [[ -n "$CMD_START_TIME" ]]; then
		local duration=$(printf "%.0f" "$(echo "($EPOCHREALTIME - $CMD_START_TIME)" | bc -l)")
		if (( duration > 5 )); then
			printf '\a'
		fi
	fi
	unset CMD_START_TIME
}

# hacky carapace set-up that makes it work with fzf-tab
carapace _carapace > ~/.cache/carapace-init.zsh 2>/dev/null || true
compinit() { : }
fpath=(/usr/share/zsh/$ZSH_VERSION/functions $fpath)
source /usr/share/zsh/$ZSH_VERSION/functions/compinit >/dev/null 2>&1
source ~/.cache/carapace-init.zsh

# Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source <(fzf --zsh)

# fzf-tab set-up
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

autoload -Uz compinit && compinit
_comp_options+=(globdots)

setopt MENU_COMPLETE
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-(checkout|commit):*' sort false
zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:(vim|nvim|vi|cat|bat|less|more|ls|eza|cd):*' fzf-preview '
  if [ -d $realpath ]; then
    eza --all --tree --level=2 --color=always --icons --group-directories-first $realpath
  elif [ -f $realpath ]; then
    bat --color=always --style=numbers --line-range :500 $realpath
  fi'

# zsh-autosuggestion configuration
bindkey '^ ' autosuggest-accept
bindkey '^[[[CE' autosuggest-execute  # CTRL + Enter
bindkey '^u' autosuggest-toggle

export XDG_CONFIG_HOME=$HOME/.config

HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# auto-activate Python virtual environments
autoload -U add-zsh-hook
_auto_activate_venv() {
  if [[ -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
  fi
}
add-zsh-hook chpwd _auto_activate_venv
_auto_activate_venv

eval "$(zoxide init --cmd cd zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # must be at the end
