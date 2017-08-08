#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

tap 'homebrew/bundle'

brew 'ack'
brew 'coreutils'
brew 'go'
brew 'grc'
brew 'imagemagick'
brew 'jp2a'
brew 'libcaca', args: ['with-imlib2']
brew 'libgit2'
brew 'openssl'
brew 'node'
brew 'readline'
brew 'postgresql'
brew 'ruby-build'
brew 'rbenv'
brew 'roundup'
brew 'spaceman-diff'
brew 'spark'
brew 'unrar'
brew 'wget'
brew 'youtube-dl'





cask '1password'
cask 'adium'
cask 'atom'
cask 'firefox'
cask 'google-chrome'
cask 'slack'
cask 'steam'
cask 'transmission'
cask 'ivpn'
cask 'vlc'
