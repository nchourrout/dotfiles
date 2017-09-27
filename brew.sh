#!/usr/bin/env bash
source ./utils/utils.sh

brew update
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Install handbrakecli
brew tap sceaga/tap
brew install handbrakecli

$PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

binaries=(
  ack
  duff
  ffmpeg
  ghostscript
  git
  hub
  node
  python
  rename
  trash
  tree
  vim
  watch
  wget
)

brew install ${binaries[@]}

brew install caskroom/cask/brew-cask

brew cleanup

apps=(
  alfred
  atom
  bartender
  charles
  cyberduck
  dropbox
  iterm2
  keepingyouawake
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-json
  skype
  sourcetree
  textbar
)

brew cask install --appdir="/Applications" ${apps[@]}

brew cask cleanup

start_if_needed Dropbox
start_if_needed Alfred

