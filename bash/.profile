eval "$(/opt/homebrew/bin/brew shellenv)"

. "$HOME/.cargo/env"

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

#### z-like jumping (IMPORTANT: THIS HAS TO BE AT THE BOTTOM OF THE FILE)
eval "$(zoxide init bash)"

function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}
