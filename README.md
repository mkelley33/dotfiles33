# dotfiles33

These are files to enhance, configure, and ignore other files.

## common configuration examples

    git config --global core.excludesfile ~/Projects/mkelley33/git/dotfiles33/.global.gitignore
    git config --global core.editor atom

## symlimks you should create
ln -s $PROJECTS/dotfiles33/rvm/gemsets/global.gems .rvm/gemsets/global.gems

## dotfiles and configs not considered useful

For now at least, I'm keeping things like my atom.io config outta here, and in
my Dropbox until the final release to make sure everything remains cool
with the licensing.
