# XDG
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# PATH
export PATH="${XDG_BIN_HOME}:${PATH}"
