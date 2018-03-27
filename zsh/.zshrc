# Load ZSH Config Files
for config (~/.zsh/*.zsh) source $config

# No GAnalytics Logging in homebrew
HOMEBREW_NO_ANALYTICS=1


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
