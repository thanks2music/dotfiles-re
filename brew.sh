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
  yarn
  wget
  curl
  openssl
  perl
  mysql
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
  mas
  glide
  heroku
  pngquant
)

echo "installing binaries..."

# TODO brew のアップデート後、インストールされていない
brew install ${binaries[@]}

# homebrew-cask

echo "installing homebrew-cask..."

brew tap caskroom/cask
brew tap caskroom/versions

apps=(
  # alfred
  # iterm2
  # keepingyouawake
  # docker
  java
  # franz
  # divvy
  # dropbox
  istat-menus
  adobe-creative-cloud
  bartender
  # dash
  evernote
  skitch
  # google-chrome
  vlc
  slack
  sequel-pro
  sublime-text
  # atom
  # google-japanese-ime
  # sourcetree
  skype
  burn
  handbrake
  # hyper
  keyboard-cleaner
  licecap
  # mamp
  transmission
  ip-in-menu-bar
  # wireshark
  # gyazo
  imageoptim
  chromium
  kindle
  local-by-flywheel
)

brew cask install --appdir="/Applications" ${apps[@]}

# link Alfred
brew cask alfred link

brew cleanup
