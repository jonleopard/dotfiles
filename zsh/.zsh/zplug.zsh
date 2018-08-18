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

zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2
zplug "mafredri/zsh-async, from:github"
zplug "sindresorhus/pure, use:pure.zsh, from:github, as:theme"
zplug "felixr/docker-zsh-completion"
zplug "bobthecow/git-flow-completion"
zplug "lukechilds/zsh-nvm"
zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-autosuggestions", defer:2, on:"zsh-users/zsh-completions"
zplug "peco/peco", \
    as:command, \
    from:gh-r 

# FZF
zplug "junegunn/fzf", \
    as:command, \
use:"bin/fzf-tmux"
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


# zplug 'zsh-users/zsh-syntax-highlighting', defer:3

# Plugins to be loaded after compinit was run.
zplug 'hlissner/zsh-autopair', \
      defer:2

zplug 'knu/z', \
      use:'z.sh', \
      defer:2

zplug 'zdharma/fast-syntax-highlighting', \
      defer:2, \
hook-load:'FAST_HIGHLIGHT=()'

zplug "knu/z", \
  use:z.sh, defer:3

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

