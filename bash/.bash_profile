if [ -s ~/.bashrc ]; then
    source ~/.bashrc;
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

bind '"\C-f":"~/dotfiles/bash/tmux-sessionizer\n"'

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source "~/.orbstack/shell/init.bash" 2>/dev/null || :



# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/jon/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP binary.
export PATH="/Users/jon/Library/Application Support/Herd/bin/":$PATH


# Herd injected PHP binary.
export PATH="/Users/jon/Library/Application Support/Herd/bin/":$PATH


# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/jon/Library/Application Support/Herd/config/php/82/"


# Herd injected PHP binary.
export PATH="/Users/jon/Library/Application Support/Herd/bin/":$PATH
