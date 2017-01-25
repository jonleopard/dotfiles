# Environment Paths

# Ruby (rbenv)
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Python (pyenv)
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Tmuxp Completion
autoload bashcompinit
bashcompinit
eval "$(_TMUXP_COMPLETE=source tmuxp)"

## Editors
export EDITOR=nvim
export VISUAL=nvim

