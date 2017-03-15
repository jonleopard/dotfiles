# Load ZSH Config Files
for config (~/.zsh/*.zsh) source $config

# Load ZPLUG
#export ZPLUG_HOME=/usr/local/opt/zplug
#source $ZPLUG_HOME/init.zsh

# No GAnalytics Logging in homebrew
HOMEBREW_NO_ANALYTICS=1

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'
    

[ -f ~/.zshrc.pluginconf ] && source ~/.zshrc.pluginconf

# For FZF
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -f ~/.zplug/init.zsh ]]; then
    export ZPLUG_LOADFILE=~/.zsh/zplug.zsh
    # For development version of zplug
    # source ~/.zplug/init.zsh
    source ~/src/github.com/zplug/zplug/init.zsh

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
        echo
    fi
    zplug load
fi
