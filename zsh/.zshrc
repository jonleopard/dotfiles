# Load ZSH Config Files
for config (~/.zsh/*.zsh) source $config

# Load ZPLUG
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# No GAnalytics Logging in homebrew
HOMEBREW_NO_ANALYTICS=1

zplug "so-fancy/diff-so-fancy", \
      if:"(($+commands[git] + $+commands[perl] + $(perl -e 'use open qw(:std :utf8);' 2> /dev/null && echo 1 || echo 0) == 3))", \
      as:command, \
      use:"diff-so-fancy"

zplug "nvie/gitflow", \
      if:"(($+commands[git]))", \
      as:command

zplug "dracula/zsh", \
      as:theme
      ZSH_THEME="dracula"

zplug "sindresorhus/pure", use:pure.zsh, defer:2
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "felixr/docker-zsh-completion"
zplug "bobthecow/git-flow-completion"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2
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

export PATH="$HOME/.bin:$PATH"
eval "$(rbenv init - --no-rehash)"
