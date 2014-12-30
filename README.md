# dotfiles

## Getting started

Before installing, you'll almost certainly want to Fork this Repository and customise it to fit your needs.

## Installation in OS X

Ensure you have installed at least the [command line developer tools](https://developer.apple.com/downloads/index.action). Ideally, you should have Xcode installed.

You are free to clone the repository anywhere you wish.

```
git clone git://github.com/nchourrout/dotfiles.git && cd dotfiles/osx
./bootstrap.sh COMPUTER_NAME
```

## Adding custom settings

You may add your own customisations by appending the dotfile name with `.local`.

* `~/.aliases.local`
* `~/.gitconfig.local`
* `~/.gvimrc.local`
* `~/.tmux.conf.local`
* `~/.vimrc.bundles.local`
* `~/.vimrc.local`
* `~/.zshrc.local`

As an example, your `~/.gitconfig.local` file might look like this:

```
[user]
  name = Nicolas Chourrout
  email = email@address.com
```

## OS X defaults

A multitude of OS X preferences can be installed by calling the defaults bash script:

```sh
cd osx
./setup_defaults.sh
```

## Install Homebrew formulae and native apps

You can use a Brewfile to set up any required [Homebrew](http://brew.sh/) formulae:

```sh
cd osx
./brew.sh
```

## Resources
My setup was cherry picked from several other dotfile repositories.
* [Ted Kulp](https://github.com/tedkulp/vim-config)
* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles/)
* [Keithbsmiley](https://github.com/Keithbsmiley/dotfiles)
* [dotfiles.github.io](http://dotfiles.github.io/)
* [thoughtbot](https://github.com/thoughtbot/dotfiles)
