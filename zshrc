# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="false"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="false"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=1

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# https://xkcd.com/1179/
HIST_STAMPS="yyyy-mm-dd"

# Aliases, functions, and maybe some other stuff are stored in other dotfiles so
# source each of the them:
other_dotfiles=('.zsh_functions' '.aliases')
for f in $other_dotfiles; do
  [[ -f ~/$f ]] && . ~/$f # && echo $f
done

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(bower brew bundler copydir copyfile osx gem git git-extras gitignore
  heroku node npm nvm postgres rsync ruby safe-paste ssh-agent vundle xcode)

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

## SSH fixes

export SSH_ENV=$HOME/.ssh/environment

# Exec this line to see (.) hidden files in MacVim open dialog.
# defaults write org.vim.MacVim AppleShowAllFiles 1

function start_agent {
  /usr/bin/ssh-agent > ${SSH_ENV}
  chmod 600 ${SSH_ENV}
  . ${SSH_ENV} > /dev/null
  /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
. ${SSH_ENV} > /dev/null
ps -x | grep "^ *${SSH_AGENT_PID}" | grep ssh-agent$ > /dev/null || {
  start_agent;
}

## end SSH fixes

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='subl -w'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

export DEFAULT_USER="mkelley33"

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export PROJECTS=$HOME/Projects/mkelley33/git
export DOTFILES=$PROJECTS/dotfiles33
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export SAVEHIST=$HISTSIZE
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
export TZ=America/New_York

source $ZSH/oh-my-zsh.sh

# Load and run compinit
autoload -U compinit
compinit -i

# ZSH treats # as an extended globbing symbol. If using bower, disable globbing.
# http://zsh.sourceforge.net/Guide/zshguide05.html
# bower install --save baz/foobar#some-branch
# zsh: no matches found: baz/foobar#some-branch
# The alias below resolves the error above when using ZSH and bower.
alias bower='noglob bower'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export NVM_SYMLINK_CURRENT=true
