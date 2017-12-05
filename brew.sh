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
  anyenv
	yarn
	wget
	curl
	openssl
  mysql
	imagemagick
	hub
	peco
	tig
	wp-cli
	cmake
	libuv
	imagemagick
  redis
  autoconf
  ffmpeg
  gcc
  gdbm
  libffi
  libidn
  libxml2
  libxslt
  libyaml
)

echo "installing binaries..."

brew install ${binaries[@]}

# homebrew-cask

echo "installing homebrew-cask..."

brew tap caskroom/cask
brew tap caskroom/versions

apps=(
  alfred
  iterm2
  keepingyouawake
  docker
  vagrant
  divvy
  istat-menus
  adobe-creative-cloud
  bartender
  dash
  popclip
  dropbox
  evernote
  skitch
  firefox
  google-chrome
  vlc
  slack
  sequel-pro
  sublime-text
  google-japanese-ime
  sourcetree
  skype
  burn
  handbrake
  hyper
  keyboard-cleaner
  licecap
  mamp
  transmission
  ip-in-menu-bar
  firefoxdeveloperedition
  wireshark
  gyazo
  imageoptim
)

brew cask install --appdir="/Applications" ${apps[@]}

# link Alfred
brew cask alfred link

brew cleanup
