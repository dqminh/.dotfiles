BASE16_SHELL="$HOME/.dotfiles/terminals/base16-shell/base16-railscast.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="daveverwer"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gpg-agent golang history-substring-search pass)

# User configuration
source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
export GOPATH=$HOME/gocode
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export GOPATH=$HOME/gocode

alias tree='tree -F'
alias gl="git log --pretty=format:'%h - %an, %ar : %s'"
alias tn='tmux new -s'
alias ta='tmux a -t'
alias tl='tmux list-sessions'

case $(uname) in
  Linux)
    export CLICOLOR=1
    alias ls='ls -lh --color=auto'
    ;;
  Darwin)
    if [ -d $HOME/.boot2docker ]; then
      export DOCKER_TLS_VERIFY=1
      export DOCKER_HOST=tcp://192.168.59.103:2376
      export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
    fi
    export CLICOLOR=1
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
    ;;
esac

if [ -f $HOME/.autoenv/activate.sh ]; then
  source $HOME/.autoenv/activate.sh
fi

if [ -d $HOME/google-cloud-sdk ]; then
  # The next line updates PATH for the Google Cloud SDK.
  source '/home/action/google-cloud-sdk/path.zsh.inc'
  # The next line enables bash completion for gcloud.
  source '/home/action/google-cloud-sdk/completion.zsh.inc'
fi

# convert bytes to human readable text
function byteme()
{
  SLIST="bytes,KB,MB,GB,TB,PB,EB,ZB,YB"
  POWER=1
  DATA=$(cat)
  VAL=$( echo "scale=2; $DATA / 1" | bc)
  VINT=$( echo $VAL / 1024 | bc )
  while [ ! $VINT = "0" ]
  do
    let POWER=POWER+1
    VAL=$( echo "scale=2; $VAL / 1024" | bc)
    VINT=$( echo $VAL / 1024 | bc )
  done
  echo $VAL$( echo $SLIST | cut -f$POWER -d, )
}

function rmi_none()              { docker rmi $(docker images | grep "<none>" | awk '{ print $3}'); }
function clean_merged_branches() { git branch --merged | grep -v "\*" | xargs -n 1 git branch -d; }
function linecount()             { find . -name "*.$1" | xargs wc -l; }
function find_replace()          { pt -l "$1" | xargs perl -pi -E "s/$1/$2/g"; }
function go_doc()                { godoc -http="localhost:6060"; }
function gocd()                  { cd `go list -f '{{.Dir}}' $1`; }
function installed_packages()    { dpkg --get-selections | grep -v deinstall; }

for file in ~/.{zshrc.local}; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
