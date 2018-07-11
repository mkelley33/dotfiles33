#!/usr/bin/env bash

# This file is pretty much what you see here with some minor modifications:
# https://raw.github.com/michaeljsmalley/dotfiles/master/makesymlinks.sh

old_dots=$HOME/old_dots
DOTS=$HOME/projects/mk/git/me/dotfiles33
# files to symlink in $HOME
files="vimrc aliases ackrc ctags gemrc inputrc pryrc rvmrc.global tmux.conf zlogin zsh_functions zshrc"
mkdir -p $old_dots && cd $old_dots
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $old_dots"
  mv $HOME/.$file $old_dots/
  echo "Creating symlink to $file in home directory."
  ln -s $DOTS/$file $HOME/.$file
done

ln -s $DOTS/gitignores/global.gitignore $HOME/.gitignore
