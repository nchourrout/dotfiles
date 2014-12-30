#!/usr/bin/env bash
# This is a script for bootstrapping OS X setup

source ../utils/utils.sh

if ! which xcodebuild &> /dev/null; then
  e_error "Xcode Command Line Tools must be installed before running this script"
  exit
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

if type_exists 'brew'; then
  e_arrow "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
else
  e_arrow "Updating homebrew..."
  brew update && brew upgrade
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  e_arrow "Installing oh my zsh..."
  git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
  chsh -s /bin/zsh
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
  echo "Updating vim bundles..."
  cd $DOTFILES/vim/bundle/neobundle.vim
  git pull origin master
  cd ~
  vim -c "NeoBundleInstall!" -c "qa!"
else
  echo "Installing vim bundles..."
  if [ ! -d "$DOTFILES/vim/bundle" ]; then
    mkdir -p $DOTFILES/vim/bundle
  fi
  git clone https://github.com/Shougo/neobundle.vim.git $DOTFILES/vim/bundle/neobundle.vim
  vim -c "NeoBundleInstall!" -c "qa!"
fi

# Install brew bundles
echo
echo
seek_confirmation "Install Brews"
if is_confirmed; then
  e_arrow "Installing Brews..."
  brew bundle $DOTFILES/osx/Brewfile
fi

echo
seek_confirmation "Install Casks?"
if is_confirmed; then
  e_arrow "Installing Casks..."
  brew bundle $DOTFILES/osx/Caskfile
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

e_success "                                                                        "
e_success "                                                                        "
e_success "........................................................................"
e_success "............................ Bootstrap done ............................"
e_success "........................................................................"
e_success "                                                                        "
e_success "                                                                        "
