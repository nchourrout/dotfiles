#!/usr/bin/env bash

source ./utils/utils.sh

e_header Bootstrap

# XCode command line tools
if ! type_exists 'xcodebuild'; then
  e_arrow "Installing them Xcode CLI tools..."
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
  softwareupdate -i "$PROD" -v;
else
  e_arrow "Xcode CLI tools OK"
fi

if ! type_exists 'brew'; then
  e_arrow "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  e_arrow "Updating homebrew..."
  brew update && brew upgrade
fi

# Symlink all the things
seek_confirmation "Install dotfiles?"
if is_confirmed; then
  cd ..
  ./manage.sh install
fi

# Re-source .bashrc to gain access to $DOTFILES alias
if [[ ! -f $HOME/.shellrc ]];then
  e_error "$HOME/.shellrc does not exist. Exiting."
  exit
else
  source "$HOME/.bashrc"
fi

# Ensure theme is setup in zsh
if [ ! -e "$HOME/.oh-my-zsh/themes/nchourrout.zsh-theme" ]; then
  ln -s $DOTFILES/themes/squarefrog.zsh-theme $HOME/.oh-my-zsh/themes/nchourrout.zsh-theme
fi

# Install brew bundles
echo
seek_confirmation "Install Brews and Casks"
if is_confirmed; then
  e_arrow "Installing brews and casks..."
  source brew.sh
fi

# TODO: Add files in bin to Path (do it in manage.sh)

# Install
seek_confirmation "Install gmailto"
if is_confirmed; then
  npm install gmailto -g
fi
 
# Install Wallpapers
seek_confirmation "Download wallpapers?"
if is_confirmed; then
    liftdownloader
fi

# Update software
seek_confirmation "Update Apple Software?"
if is_confirmed; then
    sudo softwareupdate -i -a
fi

# Setup Defaults
seek_confirmation "Customize system defaults?"
if is_confirmed; then
  cd ~/.dotfiles
  source setup_defaults.sh
fi

e_success "Bootstrap done"
