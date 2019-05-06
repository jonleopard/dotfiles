fzf-down() {
  fzf --height 50% "$@" --border
}

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'

if [ -x ~/.vim/plugged/fzf.vim/bin/preview.rb ]; then
  export FZF_CTRL_T_OPTS="--preview '~/.vim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
fi

command -v blsd > /dev/null && export FZF_ALT_C_COMMAND='blsd $dir'
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"


# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") | sed '/^$/d' |
    fzf-down --no-hscroll --reverse --ansi +m -d "\t" -n 2 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}


# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}


# Switch tmux-sessions
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}


# Base16 Snazzy
# Author: Chawye Hsu (https://github.com/h404bi) based on Hyper Snazzy Theme (https://github.com/sindresorhus/hyper-snazzy)

_gen_fzf_default_opts() {

local color00='#282a36'
local color01='#34353e'
local color02='#43454f'
local color03='#78787e'
local color04='#a5a5a9'
local color05='#e2e4e5'
local color06='#eff0eb'
local color07='#f1f1f0'
local color08='#ff5c57'
local color09='#ff9f43'
local color0A='#f3f99d'
local color0B='#5af78e'
local color0C='#9aedfe'
local color0D='#57c7ff'
local color0E='#ff6ac1'
local color0F='#b2643c'

export FZF_DEFAULT_OPTS="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"

}

_gen_fzf_default_opts
