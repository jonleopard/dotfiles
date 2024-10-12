#!bash

case $- in
*i*) ;; # interactive
*) return ;;
esac

# System
# --------------------------------------------------------------------
[ -z ${PLATFORM+x} ] && export PLATFORM=$(uname -s)


# Enviornment
# --------------------------------------------------------------------
export EDITOR=nvim

#### Node (n): note that this needs to be put before homebrew
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).


if [[ "$PLATFORM" = 'Darwin' ]]; then
  #### Force brew to use brewed CURL
  export HOMEBREW_FORCE_BREWED_CURL=1

  #### No GAnalytics Logging in homebrew
  export HOMEBREW_NO_ANALYTICS=1

  #### Tell git not to use my GitHub account (Keychain) for public repositories - it's a privacy issue
  export HOMEBREW_NO_GITHUB_API=1

  #### Configure brew to avoid protocol downgrades from HTTPS to HTTP via redirect
  export HOMEBREW_NO_INSECURE_REDIRECT=1

  #### Curl
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"

  #### sed
  export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

  #### Make
  export  PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
fi

#### Git-fuzzy
export PATH="$HOME/git-fuzzy/bin:$PATH"

#### Rust
export PATH="$HOME/.cargo/bin:$PATH"

#### Go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH=$PATH:$(go env GOPATH)/bin

#### PHP/Laravel
export PATH="$PATH:$HOME/.composer/vendor/bin"
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

#### GPG
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# Colors
# --------------------------------------------------------------------

#### For bat
export BAT_THEME="base16-256"

#### For delta
export BASE16_SHELL_ENABLE_VARS=1

#### For fd (look into vivid: https://github.com/sharkdp/vivid)
#export LS_COLORS=NO_COLOR

# Base16 Shell
BASE16_SHELL_PATH="$HOME/.config/base16-shell"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"

# base16-fzf
BASE16_FZF="$HOME/.config/base16-fzf/bash"
source "$BASE16_FZF/base16-${BASE16_THEME}.config"

# Prompt
# --------------------------------------------------------------------

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
  # dir="${PWD##*/}" # current directory
  # dir="${PWD%/*}" # parent directory
  # dir="${PWD}" # full path
  local P='$' dir="$(basename "$(dirname "$PWD")")/$(basename "$PWD")"  B countme short long double \
        #### Colors
        C_RESET='\[\e[0m\]' \
        C_BLACK='\[\e[30m\]' \
        C_RED='\[\e[31m\]' \
        C_YELLOW='\[\e[33m\]' \
        C_BLUE='\[\e[34m\]' \
        C_MAGENTA='\[\e[35m\]' \
        C_CYAN='\[\e[36m\]' \
        C_LGRAY='\[\e[37m\]'


  [[ $EUID == 0 ]] && P='#' && u=${C_RED} && p=${C_YELLOW} # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'


  # TODO: Implement a quick way to check git dirty status
  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

  [[ $B = master || $B = main ]] && b="${C_RED}"
  [[ -n "$B" ]] && B="${C_LGRAY}(${C_RED}$B${C_LGRAY})"

  short="${C_YELLOW}\u${C_LGRAY}$PROMPT_AT${C_BLUE}\h${C_LGRAY}:${C_MAGENTA}$dir$B${C_YELLOW}$P${C_RESET} "
  long="╔ ${C_YELLOW}\u${C_LGRAY}$PROMPT_AT${C_BLUE}\h${C_LGRAY}:${C_MAGENTA}$dir$B${C_RESET}\n╚ ${C_YELLOW}$P${C_RESET} "
  double="╔ ${C_YELLOW}\u${C_LGRAY}$PROMPT_AT${C_BLUE}\h${C_LGRAY}:${C_MAGENTA}$dir\n${C_LGRAY}║ $B\n${C_LGRAY}╚ ${C_YELLOW}$P${C_RESET} "

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
alias ts='tmux-sessionizer'

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
alias colors='msgcat --color=test'
alias ansi_colors='for x in {0..8}; do for i in {30..37}; do for a in {40..47}; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo ""'

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
shopt -s expand_aliases
#shopt -s globstar
shopt -s dotglob
shopt -s extglob

set -o vi ### vi mode
shopt -s histappend ### Append to the history file
shopt -s checkwinsize ### Check the window size after each command ($LINES, $COLUMNS)

#shopt -s nullglob # bug kills completion for some
#set -o noclobber


# History
# --------------------------------------------------------------------
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000
# https://web.archive.org/web/20090815205011/http://www.cuberick.com/2008/11/update-bash-history-in-realtime.html
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# fzf (https://github.com/junegunn/fzf)
# --------------------------------------------------------------------

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fzf-down() {
  fzf --height 50% "$@" --border
}

if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git'
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi

# export FZF_DEFAULT_COMMAND="rg --files"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_COMPLETION_TRIGGER='~~'
export _ZO_FZF_OPTS="--preview 'exa -1 --color=always {2..}'"
export FZF_DEFAULT_OPTS='--no-height --no-reverse'
export FZF_TMUX_OPTS='-p80%,60%'
#export FZF_TMUX='--height 30%'
# export FZF_DEFAULT_OPTS="
#      --height 40% --border
#      --bind 'tab:down' --bind 'btab:up' --bind 'ctrl-s:toggle'
# "
#export FZF_TMUX=0

## this requires tree to be installed
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

#### Use bat
command -v bat  > /dev/null && export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"

alias prev="fzf ‐‐preview 'bat ‐‐style=numbers ‐‐color=always {}'"
