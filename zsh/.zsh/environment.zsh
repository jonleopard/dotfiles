# Environment Paths

# Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Vault
export VAULT_ADDR="http://127.0.0.1:8200"

# Curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# Node (n)
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Ruby (rbenv)
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


# PHP/Laravel
export PATH="$PATH:$HOME/.composer/vendor/bin"


# Python

# Tmuxp Completion
#eval "$(_TMUXP_COMPLETE=source tmuxp)"

# Language
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LESSCHARSET=utf-8
