#!/usr/bin/env bash
 
# Ask for the administrator password upfront.
sudo -v
 
# Keep-alive: update existing `sudo` time stamp until `.osx` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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
  wget
)
 
brew install ${binaries[@]}
 
brew install caskroom/cask/brew-cask
 
brew cleanup
 
apps=(
  alfred
  brackets
  charles
  cleanmymac
  day-o
  dropbox
  evernote
  google-chrome
  iterm2
  keepingyouawake
  mailbox
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-json
  simpholders
  skype
  slack
  sourcetree
  sublime-text-3
  vlc
)
 
brew cask install --appdir="/Applications" ${apps[@]}
 
brew cask alfred link
 
brew cask cleanup
