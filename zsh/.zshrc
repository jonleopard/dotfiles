#!/usr/bin/env zsh

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# Load ZPLUG
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Load ZSH Config Files
for config (~/.zsh/*.zsh) source $config

# No GAnalytics Logging in homebrew
HOMEBREW_NO_ANALYTICS=1


# Cleaner prompt
zplug "sindresorhus/pure", use:pure.zsh, defer:2

# Load theme file
zplug 'dracula/zsh', as:theme
ZSH_THEME="dracula"




# Plugins related to git.
zplug "so-fancy/diff-so-fancy", \
      if:"(($+commands[git] + $+commands[perl] + $(perl -e 'use open qw(:std :utf8);' 2> /dev/null && echo 1 || echo 0) == 3))", \
      as:command, \
      use:"diff-so-fancy"
zplug "nvie/gitflow", \
      if:"(($+commands[git]))", \
      as:command
zplug "bobthecow/git-flow-completion"




# Plugins
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions"
zplug "mafredri/zsh-async", on:sindresorhus/pure
zplug "lukechilds/zsh-nvm"






# FZF

# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"


fzf-down() {
  fzf --height 50% "$@"
}

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'
    


zplug "zsh-users/zsh-history-substring-search", \
    defer:3 # Should be loaded last.

zplug "zsh-users/zsh-syntax-highlighting", \
    defer:3 # Should be loaded 2nd last.

zplug 'knu/z', \
    use:'z.sh', \
    defer:1



# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

[ -f ~/.zshrc.pluginconf ] && source ~/.zshrc.pluginconf

# For FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Then, source plugins and add commands to $PATH
zplug load
