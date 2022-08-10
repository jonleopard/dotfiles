#!/bin/bash

# .bashrc for Mac and Linux (Debian/Ubuntu)

case $- in
*i*) ;; # interactive
*) return ;; 
esac

# System default
# --------------------------------------------------------------------

[ -z ${PLATFORM+x} ] && export PLATFORM=$(uname -s)


# Enviornment
# --------------------------------------------------------------------
export EDITOR=nvim
export LC_COLLATE=C
export TERM=xterm-256color

#### Node (n)
#### Note that this needs to be put before homebrew
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).


if [[ "$PLATFORM" = 'Darwin' ]]; then
  #### Force brew to use brewed CURL
  HOMEBREW_FORCE_BREWED_CURL=1

  #### No GAnalytics Logging in homebrew
  HOMEBREW_NO_ANALYTICS=1

  #### Tell git not to use my GitHub account (Keychain) for public repositories - it's a privacy issue
  HOMEBREW_NO_GITHUB_API=1

  #### Configure brew to avoid protocol downgrades from HTTPS to HTTP via redirect
  HOMEBREW_NO_INSECURE_REDIRECT=1
fi


if [[ "$PLATFORM" = 'Darwin' ]]; then
  #### homebrew
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

  #### Curl
  export PATH="/usr/local/opt/curl/bin:$PATH"

  #### awk
  export PATH="/usr/local/opt/awk/bin:$PATH"

  #### sed
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

  #### Make
  export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
fi 

#### z
source "$HOME/z.sh"

#### Git-fuzzy
export PATH="$HOME/git-fuzzy/bin:$PATH"

#### Rust
export PATH="$HOME/.cargo/bin:$PATH"

#### Go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

#### PHP/Laravel
export PATH="$PATH:$HOME/.composer/vendor/bin"

#### GPG
export GPG_TTY=$(tty)


# Colors
# --------------------------------------------------------------------

#### For bat
export BAT_THEME="base16-256"

#### For FD (look into vivid: https://github.com/sharkdp/vivid)
export LS_COLORS=NO_COLOR

# Base16 Shell
BASE16_SHELL_PATH="$HOME/.config/base16-shell"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"

# Prompt
# --------------------------------------------------------------------

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@
export GIT_PS1_SHOWDIRTYSTATE=1

__ps1() {
  local P='$' dir="${PWD##*/}" B countme short long double\
    r='\[\e[31m\]' g='\[\e[37m\]' h='\[\e[34m\]' \
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
  long="╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir$B$x\n╚ $p$P$x "
  double="╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

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

#### kubectl aliases
alias k="kubectl"
alias kgx="kubectl config get-contexts"

#### docker aliases
alias d="docker"
alias dps="docker ps"

alias up="cd ../"
alias rmrf="rm -rf"
alias psef="ps -ef"
alias mkdir="mkdir -p"
alias cp="cp -r"
alias scp="scp -r"
alias mkdir="mkdir -p"
alias v="nvim"
alias cat="bat"
alias find="fd"
alias ps="procs"

# These require exa to be installed on your system
if [[ -x "`which exa`" ]]; then
  alias ls="exa"
  alias l='exa'
  alias ls='exa'
  alias la='exa -a'
  alias ll='exa -lah'
  alias lsd='exa -l' # only directories
else
  alias l='ls'
  alias la='ls -a'
  alias ll='ls -lah'
  alias lsd='ls -l' # only directories
fi


# fzf gitignore
alias gi="git-ignore"
alias ga="git add"
# These require git-fuzzy to be installed on your system
if [[ -x "`which git-fuzzy`" ]]; then
  alias gf="git fuzzy"
  alias gs="git fuzzy status"
  alias gb="git fuzzy branch"
  alias gl="git fuzzy log"
  alias gst="git fuzzy stash"
  alias gd="git fuzzy diff"
  alias gfr="git fuzzy reflog"
  alias gpr="git fuzzy pr"
else 
  alias gs="git status"
  alias gb="git branch"
  alias gl="git log"
  alias gst="git stash"
  alias gd="git diff"
  alias gfr="git reflog"
  alias gpr="git pr"
fi


alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"

TREE_IGNORE="cache|log|logs|node_modules|vendor"

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

### vi mode
set -o vi

### Append to the history file
shopt -s histappend

### Check the window size after each command ($LINES, $COLUMNS)
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

# fzf (https://github.com/junegunn/fzf)
# --------------------------------------------------------------------


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fzf-down() {
  fzf --height 50% "$@" --border
}

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git'
fi

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

command -v bat  > /dev/null && export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"


### Fancy stuff ###

# zsh; needs setopt re_match_pcre. You can, of course, adapt it to your own shell easily.
tmuxkillf () {
    local sessions
    sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
    local i
    for i in "${(f@)sessions}"
    do
        [[ $i =~ '([^:]*):.*' ]] && {
            echo "Killing $match[1]"
            tmux kill-session -t "$match[1]"
        }
    done
}

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}


#https://medium.com/@calbertts/docker-and-fuzzy-finder-fzf-4c6416f5e0b5
runc() {
  export FZF_DEFAULT_OPTS='--height 90% --reverse --border'
  local image=$(docker images --format '{{.Repository}}:{{.Tag}}' | fzf-tmux --reverse --multi)
  if [[ $image != '' ]]; then
    echo -e "\n  \033[1mDocker image:\033[0m" $image
    read -e -p $'  \e[1mOptions: \e[0m' -i "-it --rm" options

    printf "  \033[1mChoose the command: \033[0m"
    local cmd=$(echo -e "/bin/bash\nsh" | fzf-tmux --reverse --multi)
    if [[ $cmd == '' ]]; then
        read -e -p $'  \e[1mCustom command: \e[0m' cmd
    fi
    echo -e "  \033[1mCommand: \033[0m" $cmd

    export FZF_DEFAULT_COMMAND='find ./ -type d -maxdepth 1 -exec basename {} \;'
    printf "  \033[1mChoose the volume: \033[0m"
    local volume=$(fzf-tmux --reverse --multi)
    local curDir=${PWD##*/}
    if [[ $volume == '.' ]]; then
        echo -e "  \033[1mVolume: \033[0m" $volume
        volume="`pwd`:/$curDir -w /$curDir"
    else
        echo -e "  \033[1mVolume: \033[0m" $volume
        volume="`pwd`/$volume:/$volume -w /$volume"
    fi

    export FZF_DEFAULT_COMMAND=""
    export FZF_DEFAULT_OPTS=""

    history -s runc
    history -s docker run $options -v $volume $image $cmd
    echo ''
    docker run $options -v $volume $image $cmd
  fi
}


# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}


function delete-branches() {
  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview="git log {}" |
    xargs --no-run-if-empty git branch --delete --force
}




# Completion
# --------------------------------------------------------------------

### Bash completion
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


