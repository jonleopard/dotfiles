typeset -gx -U path
path=( \
    /usr/local/bin(N-/) \
    ~/bin(N-/) \
    ~/.zplug/bin(N-/) \
    ~/.tmux/bin(N-/) \
    "$path[@]" \
    )

# NOTE: set fpath before compinit
typeset -gx -U fpath
fpath=( \
    ~/.zsh/Completion(N-/) \
    ~/.zsh/functions(N-/) \
    ~/.zsh/plugins/zsh-completions(N-/) \
    /usr/local/share/zsh/site-functions(N-/) \
    $fpath \
    )

# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least

# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Editor
export EDITOR=nvim
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"
