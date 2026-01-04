# +---------+
# | ALIASES |
# +---------+

source "${ZDOTDIR}/.aliases"

# +--------+
# | PROMPT |
# +--------+

fpath+=($ZDOTDIR/plugins/pure)
autoload -U promptinit; promptinit
prompt pure

# +-----------+
# | Vi KEYMAP |
# +-----------+

bindkey -v
KEYTIMEOUT=1

bindkey -M viins '^j' down-line-or-search
bindkey -M viins '^k' up-line-or-search
bindkey -M viins '^l' vi-forward-word
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# Switch cursor shape between insert and normal mode
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

# Enable vim selections within quoted and bracketed strings
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Emulation of vim-surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# Increment a number
autoload -Uz incarg
zle -N incarg
bindkey -M vicmd '^a' incarg

# +-----+
# | fzf |
# +-----+

source <(fzf --zsh)

zle     -N            fzf-cd-widget
bindkey -M vicmd '^e' fzf-cd-widget
bindkey -M viins '^e' fzf-cd-widget

FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
FZF_DEFAULT_OPTS="--tmux --reverse"

# +------------+
# | COMPLETION |
# +------------+

# hacky carapace set-up that makes it work with fzf-tab
carapace _carapace > ~/.cache/carapace-init.zsh 2>/dev/null || true
compinit() { : }
fpath=(/usr/share/zsh/$ZSH_VERSION/functions $fpath)
source /usr/share/zsh/$ZSH_VERSION/functions/compinit >/dev/null 2>&1
source ~/.cache/carapace-init.zsh

autoload -Uz compinit && compinit
_comp_options+=(globdots)

source "${ZDOTDIR}/plugins/fzf-tab/fzf-tab.plugin.zsh"

setopt MENU_COMPLETE

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${ZDOTDIR}/.zcompcache"
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

# +------------------+
# | AUTO-SUGGESTIONS |
# +------------------+

source "${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

bindkey '^ ' autosuggest-accept
bindkey '^[[[CE' autosuggest-execute  # CTRL + Enter
bindkey '^u' autosuggest-toggle

# +---------+
# | HISTORY |
# +---------+

HISTSIZE=10000
HISTFILE="${ZDOTDIR}/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# +---------------+
# | MISCELLANEOUS |
# +---------------+

setopt CORRECT

# +--------+
# | zoxide |
# +--------+

eval "$(zoxide init --cmd cd zsh)"

# +----------------------+
# | SYNTAX HIGHLIGHTNING |
# +----------------------+

source "${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# +---------+
# | HELPERS |
# +---------+

# Ring bell if a command took longer than 5 seconds
if [[ -o interactive ]]; then
  preexec() {
    CMD_START_TIME=$EPOCHREALTIME
  }
  precmd() {
    if [[ -n "$CMD_START_TIME" ]]; then
      local duration
      duration=$(printf "%.0f" "$(echo "($EPOCHREALTIME - $CMD_START_TIME)" | bc -l)")
      if (( duration > 5 )); then
        printf '\a'
      fi
    fi
    unset CMD_START_TIME
  }
fi

# Auto-activate Python virtual environments
if [[ -o interactive ]]; then
  autoload -Uz add-zsh-hook

  _auto_activate_venv() {
    if [[ -f ".venv/bin/activate" ]]; then
      source ".venv/bin/activate"
    fi
  }

  add-zsh-hook chpwd _auto_activate_venv
  _auto_activate_venv
fi

# Change current directory when exiting Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# +------+
# | WORK |
# +------+

source "${ZDOTDIR}/.work"
