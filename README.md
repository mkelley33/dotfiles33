# dotfiles33

Thirty-three is my luck number, and I'm @mkelley33.

These are files to enhance, configure, and ignore other files.

## symlimks you should create
ln -s $DOTFILES/rvm/gemsets/global.gems .rvm/gemsets/global.gems
ln -s $DOTFILES/bootstrap_gitconfig.sh .bootstrap_gitconfig.sh

## TODO: create more "bootstrap" scripts

**Note:** I was only able to execute sh script under zsh with
shebang like so:

    #! /bin/sh
