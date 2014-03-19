#! /bin/sh

# ln -s $DOTFILES/bootstrap_gitconfig.sh .bootstrap_gitconfig.sh
# then in .zshrc ./.bootstrap_gitconfig.sh
# aliases managed by git .aliases file and zsh git plugin

git config --global user.name "Michaux Kelley"
git config --global user.email "michauxkelley@gmail.com"

git config --global merge.stat true
git config --global diff.mnemonicprefix true
git config --global branch.autosetupmerge true
git config --global push.default tracking
git config --global rerere.enabled true

git config --global core.editor atom
git config --global core.ignore $DOTFILES/gitignores/global.gitignore
git config --global core.whitespace trailing-space,space-before-tab

git config --global color.ui auto

git config --global advice.pushNonFastForward false
git config --global advice.statusHints false
