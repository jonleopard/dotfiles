# For Homebrew
export PATH="/usr/local/sbin:$PATH"

# Load ZSH Config Files
for config (~/.zsh/*.zsh) source $config

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential for zplug
source ~/.zplug/init.zsh


# zplug for managing zsh plugins
source ~/.zplug/init.zsh

# No GAnalytics Logging in homebrew
HOMEBREW_NO_ANALYTICS=1

# zsh theme
zplug "dracula/zsh", from:oh-my-zsh,  use:dracula.zsh-theme

# prompt
zplug "sindresorhus/pure", use:pure.zsh, nice:9

### zplug plugins
zplug "zsh-users/zsh-completions", as:plugin, use:"src"
zplug "mafredri/zsh-async", on:sindresorhus/pure
zplug "lukechilds/zsh-nvm"
zplug "knu/z", use:z.sh, nice:10
zplug "peco/peco", as:command, from:gh-r
zplug "k4rthik/git-cal", as:command
zplug "supercrabtree/k"
zplug "zsh-users/zsh-syntax-highlighting", nice:10


# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

[ -f ~/.zshrc.pluginconf ] && source ~/.zshrc.pluginconf
