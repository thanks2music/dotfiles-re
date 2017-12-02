# Check Homebrew
# Install if we don't have it
#
# Courtesy od lapwinglabs.com

if test ! $(which brew); then
  echo "Installing homebrew"
  ruby -e "$(curl -fsSl https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew is already installed"
fi

# Update homebrew recipes
brew update

# Other useful binaries
binaries=(
	zsh
	git
	neovim
	wget
	curl
	openssl
	imagemagick
	hub
	peco
	yarn
	nodebrew
	tig
	wp-cli
	cmake
	libuv
	imagemagick
)

echo "installing binaries..."

brew install ${binaries[@]}

# homebrew-cask

echo "installing homebrew-cask..."

brew tap caskroom/cask
brew tap caskroom/versions

apps=(
  alfred
  keepingyouawake
  dash
  dropbox
  evernote
  firefox
  google-chrome
  iterm2
  vlc
  slack
  sequel-pro
  sublime-text
  google-japanese-ime
  sourcetree
  skype
  docker
  vagrant
  divvy
  istat-menus
  adobe-creative-cloud
  bartender
  burn
  handbrake
  hyper
  keyboard-cleaner
  licecap
  mamp
  transmission
)

brew cask install --appdir="/Applications" ${apps[@]}

# link Alfred
brew cask alfred link

brew cleanup
