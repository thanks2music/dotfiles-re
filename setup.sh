#!/bin/bash

set -eu

readonly local_bin_dir=$HOME/bin
readonly local_dotconfig_dir=$HOME/.config
readonly dotfiles_dir=$HOME/dotfiles-re

function topic {
  echo -en "\033[1;30m"
  echo "$*"
  echo -en "\033[0m"
}

topic 'Clone the repository'

if [ -d $dotfiles_dir ]; then
  echo 'dotfiles repository already exists'
else
  git clone --recursive https://github.com/thanks2music/dotfile-re.git $dotfiles_dir
fi

topic 'Setup dotfiles'

for dotfile in `find $dotfiles_dir -maxdepth 1 -mindepth 1 -name 'dot.*' | grep -v 'example'`; do
  dest=$HOME/`basename $dotfile | sed -e 's/^dot\./\./'`
  echo 'Linking' $dotfile '->' $dest
  ln -sfn $dotfile $dest
done

for dotfile in `find $dotfiles_dir -maxdepth 1 -mindepth 1 -type f -name 'dot.*.example'`; do
  dest=$HOME/`basename $dotfile | sed -e 's/^dot\./\./' | sed -e 's/\.example//'`
  if [ ! -f $dest ]; then
    echo 'Copying' $dotfile '->' $dest
    cp $dotfile $dest
  fi
done

topic 'Setup Homebrew'

if [ `uname` = "Darwin" ]; then
  if type brew > /dev/null 2>&1; then
    echo 'Homebrew is already installed'
  else
    echo 'Installing Homebrew'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    $dotfiles_dir/brew.sh
  fi
else
  echo 'This environment does not need Homebrew'
fi

topic 'Setup anyenv'

if type anyenv > /dev/null 2>&1; then
  echo 'anyenv is already installed'
else
  echo 'Installing anyenv'
  git clone https://github.com/riywo/anyenv $HOME/.anyenv
  mkdir -p $HOME/.anyenv/plugins
  git clone https://github.com/znz/anyenv-update.git $HOME/.anyenv/plugins/anyenv-update
fi
