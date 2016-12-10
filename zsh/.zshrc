#!/usr/bin/env zsh

# Homebrew
 export PATH="/usr/local/sbin:$PATH"

# Load ZPLUG
  export ZPLUG_HOME=/usr/local/opt/zplug
  source $ZPLUG_HOME/init.zsh

# Prettier colors
alias v='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'

# Load ZSH Config Files
for config (~/.zsh/*.zsh) source $config

# No GAnalytics Logging in homebrew
HOMEBREW_NO_ANALYTICS=1

# zsh theme
# zplug "agnoster/agnoster-zsh-theme", from:oh-my-zsh,  as:theme

# prompt
zplug "sindresorhus/pure", use:pure.zsh, defer:2


# Plugins related to git.
zplug "so-fancy/diff-so-fancy", \
      if:"(($+commands[git] + $+commands[perl] + $(perl -e 'use open qw(:std :utf8);' 2> /dev/null && echo 1 || echo 0) == 3))", \
      as:command, \
      use:"diff-so-fancy"
zplug "nvie/gitflow", \
      if:"(($+commands[git]))", \
      as:command
zplug "bobthecow/git-flow-completion"

### Plugins
zplug "zsh-users/zsh-completions", as:plugin, use:"src"
zplug "mafredri/zsh-async", on:sindresorhus/pure
zplug "lukechilds/zsh-nvm"
zplug "peco/peco", as:command, from:gh-r
zplug "zlsun/solarized-man"
zplug "seebi/dircolors-solarized"

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"

# Plugins to be loaded after compinit was run.
zplug 'zsh-users/zsh-syntax-highlighting', \
      defer:2, \

zplug 'knu/z', \
      use:'z.sh', \
      defer:2,


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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Then, source plugins and add commands to $PATH
zplug load --verbose
