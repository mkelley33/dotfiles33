#!/usr/bin/env bash

# This file is pretty much what you see here with some minor modifications:
# https://raw.github.com/michaeljsmalley/dotfiles/master/makesymlinks.sh

dots=$HOME/$DOTFILES
old_dots=$HOME/old_dots

# files to symlink in $HOME
files="vimrc aliases ctags gemrc inputrc pryrc rvmrc.global tmux.conf zlogin zsh_functions zshrc"
mkdir -p $old_dots && cd $old_dots
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $old_dots"
  mv $HOME/.$file $old_dots/
  echo "Creating symlink to $file in home directory."
  ln -s $DOTFILES/$file $HOME/.$file
done
