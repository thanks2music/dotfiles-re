#!/bin/bash

set -eu

# Make sure using latest Homebrew
brew update

# Update already-installed formula (takes too much time, I will do it manually later)
# brew upgrade

# Add Repository
brew tap caskroom/cask
brew tap caskroom/versions
brew tap shiwano/formulas
brew tap delphinus/macvim-kaoriya

# Packages
brew install git
brew install zsh
brew install reattach-to-user-namespace
brew install lua
brew install tmux

# Remove outdated versions
brew cleanup
