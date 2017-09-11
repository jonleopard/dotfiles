#!/usr/bin/env zsh

# load zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "so-fancy/diff-so-fancy", \
      if:"(($+commands[git] + $+commands[perl] + $(perl -e 'use open qw(:std :utf8);' 2> /dev/null && echo 1 || echo 0) == 3))", \
      as:command, \
      use:"diff-so-fancy"

zplug "nvie/gitflow", \
      if:"(($+commands[git]))", \
      as:command

zplug "dracula/zsh", \
      as:theme

zplug "mafredri/zsh-async, from:github"
zplug "sindresorhus/pure, use:pure.zsh, from:github, as:theme"
zplug "felixr/docker-zsh-completion"
zplug "bobthecow/git-flow-completion"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
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

# z
# Navigate your most used directories based on 'frecency'.
# https://github.com/rupa/z
zplug 'rupa/z', use:'*.sh'

# zsh-syntax-highlighting
# Syntax highlighing for the command line.
# https://github.com/zsh-users/zsh-syntax-highlighting
zplug 'zsh-users/zsh-syntax-highlighting', defer:3

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi


# Then, source plugins and add commands to $PATH
zplug load

