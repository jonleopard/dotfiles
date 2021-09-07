# Environment Paths

# Node (n)
# Note that this needs to be put before homebrew
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
  
# homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# Make
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# PHP/Laravel
export PATH="$PATH:$HOME/.composer/vendor/bin"

# GPG
export GPG_TTY=$(tty)

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
