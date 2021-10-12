#!/bin/bash

# .bashrc for Mac and Linux (Ubuntu)

# System default
# --------------------------------------------------------------------

[ -z ${PLATFORM+x} ] && export PLATFORM=$(uname -s)

BASE=$(dirname $(readlink $BASH_SOURCE))

# Options
# --------------------------------------------------------------------

### vi mode
set -o vi

### Append to the history file
shopt -s histappend

### Check the window size after each command ($LINES, $COLUMNS)
shopt -s checkwinsize

### Bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


# Homebrew (Mac only)
# --------------------------------------------------------------------

if [ "$PLATFORM" = 'Darwin' ]; then
  # Force brew to use brewed CURL
  HOMEBREW_FORCE_BREWED_CURL=1

  # No GAnalytics Logging in homebrew
  HOMEBREW_NO_ANALYTICS=1

  # Tell git not to use my GitHub account (Keychain) for public repositories - it's a privacy issue
  HOMEBREW_NO_GITHUB_API=1

  # Configure brew to avoid protocol downgrades from HTTPS to HTTP via redirect
  HOMEBREW_NO_INSECURE_REDIRECT=1
fi


# Enviornment
# --------------------------------------------------------------------

# Node (n)
# Note that this needs to be put before homebrew
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
  

if [ "$PLATFORM" = 'Darwin' ]; then
  # homebrew
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

  # Curl
  export PATH="/usr/local/opt/curl/bin:$PATH"

  # awk
  export PATH="/usr/local/opt/awk/bin:$PATH"

  # sed
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

  # Make
  export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
fi 

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# PHP/Laravel
export PATH="$PATH:$HOME/.composer/vendor/bin"

# GPG
export GPG_TTY=$(tty)


# Colors
# --------------------------------------------------------------------

# For bat
export BAT_THEME="base16-256"

# For FD (look into vivid: https://github.com/sharkdp/vivid)
export LS_COLORS=NO_COLOR

# Use base16-shell to swtich shell colors
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"



# fzf (https://github.com/junegunn/fzf)
# --------------------------------------------------------------------


[ -f ~/.fzf.bash ] && source ~/.fzf.bash



# Prompt
# --------------------------------------------------------------------

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
  local P='$' dir="${PWD##*/}" B countme short long double\
    r='\[\e[31m\]' g='\[\e[30m\]' h='\[\e[34m\]' \
    u='\[\e[33m\]' p='\[\e[33m\]' w='\[\e[35m\]' \
    b='\[\e[36m\]' x='\[\e[0m\]'

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

  [[ $B = master || $B = main ]] && b="$r"
  [[ -n "$B" ]] && B="$g($b$B$g)"

  short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
  long="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$p$P$x "
  double="$u\u$g$PROMPT_AT$h\h$g:$w$dir\n$B\n$p$P$x "

  if (( ${#countme} > PROMPT_MAX )); then
    PS1="$double"
  elif (( ${#countme} > PROMPT_LONG )); then
    PS1="$long"
  else
    PS1="$short"
  fi
}

PROMPT_COMMAND="__ps1"

# Aliases
# --------------------------------------------------------------------

# kubectl aliases
alias k="kubectl"
alias kgx="kubectl config get-contexts"

# docker aliases
alias d="docker"
alias dps="docker ps"

TREE_IGNORE="cache|log|logs|node_modules|vendor"
alias ls="exa"
alias l='exa'
alias ls='exa'
alias la='exa -a'
alias ll='exa -lah'
alias lsd='exa -l' # only directories

alias cat="bat"

alias find="fd"

alias ps="procs"

alias up="cd ../"
alias rmrf="rm -rf"
alias psef="ps -ef"
alias mkdir="mkdir -p"
alias cp="cp -r"
alias scp="scp -r"
alias mkdir="mkdir -p"
alias v="nvim"


# fzf gitignore
alias gi="git-ignore"

alias ga="git add"
# These require git-fuzzy to be installed on your system
alias gf="git fuzzy"
alias gs="git fuzzy status"
alias gb="git fuzzy branch"
alias gl="git fuzzy log"
alias gst="git fuzzy stash"
alias gd="git fuzzy diff"
alias gfr="git fuzzy reflog"
alias gpr="git fuzzy pr"


alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; sudo npm install npm -g; sudo npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Recursively delete `.DS_Store` files (uses fd https://github.com/sharkdp/fd)
alias cleanup="fd -IH '^\.DS_Store$' -tf -X rm -i"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Bash shell options
# --------------------------------------------------------------------
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
#shopt -s nullglob # bug kills completion for some
#set -o noclobber

# History
# --------------------------------------------------------------------
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=
export HISTFILESIZE=

shopt -s histappend
