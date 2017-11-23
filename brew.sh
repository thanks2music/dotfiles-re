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
brew install zsh
brew install git
brew install reattach-to-user-namespace
brew install lua
brew install tmux
brew install wget
brew install mysql
brew install jpeg
brew install ffmpeg
brew install gnu-sed
brew install curl
brew install openssl
brew install libxml2
brew install imagemagick
brew install hub
brew install peco

# .dmg
brew cask install iterm2
brew cask install macvim-kaoriya
brew cask install docker
brew cask install google-chrome
brew cask install firefox
brew cask install alfred
brew cask install appcleaner
brew cask install dropbox
brew cask install slack
brew cask install sequel-pro
brew cask install licecap
brew cask install wireshark-chmodbpf
brew cask install gyazo

# Remove outdated versions
brew cleanup
