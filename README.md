# dotfiles33

These are files to enhance, configure, and ignore other files.

## symlimks you should create
ln -s $DOTFILES/rvm/gemsets/global.gems .rvm/gemsets/global.gems
ln -s $DOTFILES/bootstrap_gitconfig.sh .bootstrap_gitconfig.sh

## dotfiles and configs not considered useful

For now at least, I'm keeping things like my atom.io config outta here, and in
my Dropbox until the final release to make sure everything remains cool
with the licensing.

## TODO: create more "bootstrap" scripts

**Note:** I was only able to execute sh script under zsh with
shebang like so:

    #! /bin/sh
