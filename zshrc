# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"

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
other_dotfiles=(".zsh_functions" ".aliases" ".jwtrc" ".env" ".workrc")
for f in $other_dotfiles; do
  [[ -f ~/$f ]] && . ~/$f #&& echo "loading dotfiles ${f}"
done

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(antigen bower brew brew-cask bundler copydir copyfile osx gem git git-extras gitignore heroku json_tools node
  npm postgres rsync ruby safe-paste ssh-agent vundle xcode vagrant django mercurial pep8 pip pylint
  virtualenvwrapper yarn zsh-256color you-should-use zsh-brew-services terminal-workload-report zsh-snippets zsh-nvm)

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_SYMBOL=∞
SPACESHIP_PROMPT_DEFAULT_PREFIX="∵ "
SPACESHIP_TIME_SHOW=true

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

## SSH fixes

export SSH_ENV=$HOME/.ssh/environment

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
  export EDITOR='atom -w'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

export DEFAULT_USER="mkelley33"

export PATH=/usr/local/opt/python/libexec/bin:$PATH

export PIP_REQUIRE_VIRTUALENV=false
export PROJECTS=$HOME/Projects/MK/git
export DOTFILES=$PROJECTS/dotfiles33

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Command-line fu search util in color - https://github.com/ncrocfer/clf
export CLF_COLOR=1

# Projects
export MK=$HOME/Projects/MK/git
export OPP=$HOME/Projects/OPP

export PYCHARM_VM_OPTIONS=$HOME/pycharm.vmoptions

# https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt autolist                  # filename completion
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt APPEND_HISTORY            # Allow multiple terminal sessions to all append to one zsh command history
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
# Make some commands not show up in history
export HISTIGNORE="ls:la:cd:cd -:cd --:pwd:exit:date:* --help"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
export TZ=America/New_York

# Load and run compinit
autoload -U compinit
compinit -i

# ZSH treats # as an extended globbing symbol. If using bower, disable globbing.
# http://zsh.sourceforge.net/Guide/zshguide05.html
# bower install --save baz/foobar#some-branch
# zsh: no matches found: baz/foobar#some-branch
# The alias below resolves the error above when using ZSH and bower.
alias bower='noglob bower'

export NVM_SYMLINK_CURRENT=true

# Required for https://github.com/swagger-api/swagger-codegen
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH=${JAVA_HOME}/bin:$PATH

source $ZSH/oh-my-zsh.sh

export NVM_DIR="/Users/mkelley33/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export ANTIGEN_LOG=$HOME/.antigen-logs/antigen.log
source /usr/local/share/antigen/antigen.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"

# iftop: display bandwidth usage on an interface
alias iftop=/usr/local/opt/iftop/sbin/iftop

# brew install zsh-history-substring-search
# echo 'source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh' >> ~/.zshrc
# type any part of any command, press up / down arrows, see matching commands in your history, and smile
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' completions '#'
zstyle ':completion:*' glob '_'
zstyle ':completion:*' substitute '%'
zstyle :compinstall filename '/Users/mkelley33/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

launchctlFind () {
    LaunchctlPATHS=( \
        ~/Library/LaunchAgents \
        /Library/LaunchAgents \
        /Library/LaunchDaemons \
        /System/Library/LaunchAgents \
        /System/Library/LaunchDaemons \
    )

    for curPATH in "${LaunchctlPATHS[@]}"
    do
        grep -r "$curPATH" -e "$1"
    done
    return 0;
}
export PATH="/usr/local/opt/berkeley-db@4/bin:$PATH"

export PATH="/usr/local/opt/curl/bin:$PATH"

source "/Users/mkelley33/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
