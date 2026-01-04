export EDITOR="nvim"
export VISUAL="nvim"

if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="${XDG_BIN_HOME}:${PATH}"
