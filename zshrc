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

# Uncomment following line if you want to disable autosetting terminal title.
export DISABLE_AUTO_TITLE="false"

# Uncomment following line if you want to disable command autocorrection
export DISABLE_CORRECTION="false"

# Uncomment following line if you want red dots to be displayed while waiting for completion
export COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
export DISABLE_UNTRACKED_FILES_DIRTY="false"

# Comment following line if you don't want shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# https://xkcd.com/1179/
export HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(antigen brew brew-cask bundler copydir copyfile osx gem git git-extras gitignore heroku json_tools node
  npm postgres rsync ruby safe-paste ssh-agent vundle xcode yarn zsh-256color you-should-use zsh-brew-services 
  terminal-workload-report zsh-snippets zsh-nvm)

export SPACESHIP_PROMPT_ADD_NEWLINE=false
export SPACESHIP_PROMPT_SEPARATE_LINE=false
export SPACESHIP_CHAR_SYMBOL="# "
export SPACESHIP_PROMPT_DEFAULT_PREFIX="∵ "
export SPACESHIP_TIME_SHOW=true

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH

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

eval $(ssh-agent)

## end SSH fixes

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code -w'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

export USER_FULL_NAME="Michaux Kelley"
export USER_EMAIL="michauxkelley@gmail.com"
export DEFAULT_USER="ccha0s"

export PROJECTS=$HOME/projects/mk/git
export ME=$PROJECTS/me
export DOTS=$ME/dotfiles33
export DROPBOX_PATH=$HOME/Dropbox

# Command-line fu search util in color - https://github.com/ncrocfer/clf
export CLF_COLOR=1

# Projects
export MK=$HOME/Projects/MK/git
export OPP=$HOME/Projects/OPP

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
export HISTORY_IGNORE="ls|la|cd|cd -|cd -2|cd -3|cd --|pwd|exit|date|man"

# Prefer US English and use UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TZ=America/New_York

# Required for https://github.com/swagger-api/swagger-codegen
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_172`
export PATH=${JAVA_HOME}/bin:$PATH

source $ZSH/oh-my-zsh.sh

# Dot files that contain aliases, functions, etc. (Examples: ".django-aliases" ".workrc"):
other_dotfiles=(".zsh_functions" ".aliases" ".jwtrc" ".env")
echo "Sourcing dotfiles"
echo "-----------------"
for f in $other_dotfiles; do
  [[ -f ~/$f ]] && . ~/$f && echo "${f}"
done
echo "-----------------"

export NVM_SYMLINK_CURRENT=true
export NVM_DIR="/Users/${DEFAULT_USER}/.nvm"
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

export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
