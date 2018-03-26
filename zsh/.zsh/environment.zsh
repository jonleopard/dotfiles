# Environment Paths

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# Vault
export VAULT_ADDR='http://127.0.0.1:8200'

# Curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# Ruby (rbenv)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Look into improving NVM loading times
# https://github.com/creationix/nvm/issues/1277

# Tmuxp Completion
# Will fix later, see (https://github.com/creationix/nvm/issues/1650)
#eval "$(_TMUXP_COMPLETE=source tmuxp)"

