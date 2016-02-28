HISTSIZE=99999
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

C_NONE='\[\033[0m\]'
C_RED='\[\033[0;31m\]'
C_GREEN='\[\033[0;32m\]'
C_BLUE='\[\033[0;34m\]'
C_YELLOW='\[\033[1;33m\]'
C_WHITE='\[\033[1;37m\]'
C_BOLD='\[\e[1;91m\]'

export PS1="$C_GREEN\u$C_RED|$C_WHITE\w$C_BLUE >$C_NONE "

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

if [ -f /usr/local/etc/bash_completion.d/password-store ]; then
  source /usr/local/etc/bash_completion.d/password-store
fi

if [ -d $HOME/google-cloud-sdk ]; then
  # The next line updates PATH for the Google Cloud SDK.
  source '/home/action/google-cloud-sdk/path.zsh.inc'
  # The next line enables bash completion for gcloud.
  source '/home/action/google-cloud-sdk/completion.zsh.inc'
fi

export EDITOR=vim
export GOPATH=$HOME/gocode
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
export GO15VENDOREXPERIMENT=1
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
# tools for moving around GOPATH
export CDPATH=$GOPATH/src/github.com:$GOPATH/src/code.google.com/p

alias tree='tree -F'
alias gl="git log --pretty=format:'%h - %an, %ar : %s'"
alias tn='tmux new -s'
alias ta='tmux a -t'
alias tl='tmux list-sessions'

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
