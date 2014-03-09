#! /usr/local/bin bash

# This file is pretty much what you see here with some minor modifications:
# https://raw.github.com/michaeljsmalley/dotfiles/master/makesymlinks.sh

dots=$HOME/$DOTFILES
old_dots=$HOME/old_dots

# files to symlink in $HOME
files="vimrc ackrc aliases ctags gemrc inputrc pryrc rvmrc tmux.conf zlogin zsh_functions zshrc"
mkdir -p $old_dots && cd $old_dots
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $old_dots"
  mv ~/.$file ~/$old_dots/
  echo "Creating symlink to $file in home directory."
  ln -s $PROJECTS/$DOTFILES/$file ~/.$file
done

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone http://github.com/michaeljsmalley/oh-my-zsh.git
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install zsh
        install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh
