if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}

bind '"\C-f":"~/dotfiles/bash/tmux-sessionizer\n"'

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source "~/.orbstack/shell/init.bash" 2>/dev/null || :

