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

# prompt
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

### Plugins
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions"

zplug "mafredri/zsh-async", on:sindresorhus/pure
zplug "lukechilds/zsh-nvm"


zplug 'junegunn/fzf', \
    as:command, \
    hook-build:'./install --bin >/dev/null', \
    use:'bin/fzf', \
    rename-to:'fzf', \
    if:'(( $+commands[go] ))'

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    use:"*${(L)$(uname -s)}*amd64*", \
    rename-to:fzf, \

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
