#!bash

case $- in
*i*) ;; # interactive
*) return ;;
esac

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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

#### PHP/Laravel
export PATH="$PATH:$HOME/.composer/vendor/bin"
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

#### GPG
export GPG_TTY=$(tty)
##gpgconf --launch gpg-agent

# Colors
# --------------------------------------------------------------------

# # Tinty isn't able to apply environment variables to your shell due to
# the way shell sub-processes work. This is a work around by running
# Tinty through a function and then executing the shell scripts.
tinty_source_shell_theme() {
  newer_file=$(mktemp)
  tinty $@
  subcommand="$1"

  if [ "$subcommand" = "apply" ] || [ "$subcommand" = "init" ]; then
    tinty_data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty"

    while read -r script; do
      # shellcheck disable=SC1090
      . "$script"
    done < <(find "$tinty_data_dir" -maxdepth 1 -type f -name "*.sh" -newer "$newer_file")

    unset tinty_data_dir
  fi

  unset subcommand
}

if [ -n "$(command -v 'tinty')" ]; then
  tinty_source_shell_theme "init" > /dev/null

  alias tinty=tinty_source_shell_theme
fi

#### For bat
export BAT_THEME="base16-256"

#### For delta
export TINTED_SHELL_ENABLE_BASE16_VARS=1
export TINTED_SHELL_ENABLE_BASE24_VARS=1

#### For fd (look into vivid: https://github.com/sharkdp/vivid)
export LS_COLORS=NO_COLOR

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
if [[ -x "`which eza`" ]]; then
  alias ls="eza"
  alias l='eza'
  alias ls='eza'
  alias la='eza -a'
  alias ll='eza -lah'
  alias lsd='eza -l' # only directories
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

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Bash shell options
# --------------------------------------------------------------------
shopt -s expand_aliases
shopt -s dotglob
shopt -s extglob
shopt -s histappend ### Append to the history file
shopt -s checkwinsize ### Check the window size after each command ($LINES, $COLUMNS)

set -o vi ### vi mode

# History
# --------------------------------------------------------------------
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000
# https://web.archive.org/web/20090815205011/http://www.cuberick.com/2008/11/update-bash-history-in-realtime.html
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# fzf (https://github.com/junegunn/fzf)
# --------------------------------------------------------------------

export FZF_DEFAULT_OPTS='--height 70% --tmux 70%'

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# processes
process() {
(date; ps -ef) |
  fzf --bind='ctrl-r:reload(date; ps -ef)' \
      --header=$'Press CTRL-R to reload\n\n' --header-lines=2 \
      --preview='echo {}' --preview-window=down,3,wrap \
      --layout=reverse --height=80% | awk '{print $2}' | xargs kill -9
}

# find session
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# find in file
fif() {
RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY="${*:-}"
fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --bind "alt-enter:unbind(change,alt-enter)+change-prompt(2. fzf> )+enable-search+clear-query" \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --prompt '1. ripgrep> ' \
    --delimiter : \
    --preview 'bat --color=always {1} --highlight-line {2}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    --bind 'enter:become(nvim {1} +{2})'
}


####################################################################
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --bash)"
#### z-like jumping (IMPORTANT: THIS HAS TO BE AT THE BOTTOM OF THE FILE)
eval "$(zoxide init bash)"


