# Environment Paths

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# Vault
export VAULT_ADDR='http://127.0.0.1:8200'

# Curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# Ruby (rbenv)
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Python (pyenv)
#export PYENV_VIRTUALENV_DISABLE_PROMPT=1
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"

# Tmuxp Completion
autoload bashcompinit
bashcompinit
