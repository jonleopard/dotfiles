#zmodload zsh/zprof
# Load ZSH Config Files
for config (~/.zsh/*.zsh) source $config

# No GAnalytics Logging in homebrew
HOMEBREW_NO_ANALYTICS=1

# Tell git not to use my GitHub account (Keychain) for public repositories - it's a privacy issue
HOMEBREW_NO_GITHUB_API=1

#zprof


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
