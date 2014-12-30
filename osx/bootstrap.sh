#!/usr/bin/env bash

source ../utils/utils.sh

if ! type_exists 'xcodebuild'; then
  e_error "Xcode Command Line Tools must be installed before running this script"
  exit 1
fi

echo "                                                                             ";
echo "                                                                             ";
echo " ██████╗  ██████╗  ██████╗ ████████╗███████╗████████╗██████╗  █████╗ ██████╗ ";
echo " ██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗";
echo " ██████╔╝██║   ██║██║   ██║   ██║   ███████╗   ██║   ██████╔╝███████║██████╔╝";
echo " ██╔══██╗██║   ██║██║   ██║   ██║   ╚════██║   ██║   ██╔══██╗██╔══██║██╔═══╝ ";
echo " ██████╔╝╚██████╔╝╚██████╔╝   ██║   ███████║   ██║   ██║  ██║██║  ██║██║     ";
echo " ╚═════╝  ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ";
echo "                                                                             ";
echo "                                                                             ";

if ! type_exists 'brew'; then
  e_arrow "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  e_arrow "Updating homebrew..."
  brew update && brew upgrade
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  e_arrow "Installing oh my zsh..."
  curl -L http://install.ohmyz.sh | sh
fi

# Symlink all the things
cd ..
./manage.sh install

# Re-source .bashrc to gain access to $DOTFILES alias
if [[ ! -f $HOME/.shellrc ]];then
  echo "$HOME/.shellrc does not exist. Exiting."
  exit
else
  source "$HOME/.bashrc"
fi

# Ensure theme is setup in zsh
if [ ! -e "$HOME/.oh-my-zsh/themes/squarefrog.zsh-theme" ]; then
  ln -s $DOTFILES/themes/squarefrog.zsh-theme $HOME/.oh-my-zsh/themes/squarefrog.zsh-theme
fi

# Setup Xcode theme
if [ ! -d "$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes/tomorrow-night-xcode.dvcolortheme" ]; then
  mkdir -p "$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes"
  cp "$DOTFILES/themes/tomorrow-night-xcode.dvcolortheme" "$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes"
fi

# Install vim packages
if [ -d "$DOTFILES/vim/bundle/neobundle.vim" ]; then
  e_arrow "Updating vim bundles..."
  cd $DOTFILES/vim/bundle/neobundle.vim
  git pull origin master
  cd ~
  vim -c "NeoBundleInstall!" -c "qa!"
else
  e_arrow "Installing vim bundles..."
  if [ ! -d "$DOTFILES/vim/bundle" ]; then
    mkdir -p $DOTFILES/vim/bundle
  fi
  git clone https://github.com/Shougo/neobundle.vim.git $DOTFILES/vim/bundle/neobundle.vim
  vim -c "NeoBundleInstall!" -c "qa!"
fi

# Install brew bundles
echo
echo
seek_confirmation "Install Brews and Casks"
if is_confirmed; then
  e_arrow "Installing brews and casks..."
  source brew.sh
fi

# TODO: Add files in bin to Path (do it in manage.sh)

# Install Alcatraz XCode plugin manager
seek_confirmation "Install Alcatraz?"
if is_confirmed; then
    e_arrow "Installing Alcatraz"
    curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
fi
 
# Install Wallpapers
seek_confirmation "Download wallpapers?"
if is_confirmed; then
    liftdownloader
fi

sudo softwareupdate -i -a

e_success "                                                                        "
e_success "                                                                        "
e_success "........................................................................"
e_success "............................ Bootstrap done ............................"
e_success "........................................................................"
e_success "                                                                        "
e_success "                                                                        "
