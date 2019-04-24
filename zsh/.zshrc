#zmodload zsh/zprof
# Load ZSH config files
for config (~/.zsh/*.zsh) source $config

# No GAnalytics Logging in homebrew
HOMEBREW_NO_ANALYTICS=1

# Tell git not to use my GitHub account (Keychain) for public repositories - it's a privacy issue
HOMEBREW_NO_GITHUB_API=1

# Configure brew to avoid protocol downgrades from HTTPS to HTTP via redirect
HOMEBREW_NO_INSECURE_REDIRECT=1

autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

#zprof
