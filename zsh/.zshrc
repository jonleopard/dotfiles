#zmodload zsh/zprof

# Load ZSH config files
for config (~/.zsh/*.zsh) source $config

# Force brew to use brewed CURL
HOMEBREW_FORCE_BREWED_CURL=1

# No GAnalytics Logging in homebrew
HOMEBREW_NO_ANALYTICS=1

# Tell git not to use my GitHub account (Keychain) for public repositories - it's a privacy issue
HOMEBREW_NO_GITHUB_API=1

# Configure brew to avoid protocol downgrades from HTTPS to HTTP via redirect
HOMEBREW_NO_INSECURE_REDIRECT=1


### The nitty gritty ###

# I use FZF, Z, and fd to hop around directories. This is nice to have.
setopt auto_cd

# Don't store invalid/mistyped commands in zhistory file.
# You can still `up arrow` to modify a failed command,
# but at least the failed version won't be stored in history
# http://www.zsh.org/mla/users//2014/msg00715.html
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

#zprof

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
