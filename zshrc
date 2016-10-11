bindkey -e # use emacs mode explicitly

# User configuration
export EDITOR='vim'
export GOPATH=$HOME/gocode
export PATH=$GOPATH/bin:/usr/local/go/bin:/usr/local/sbin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export RUST_SRC_PATH=/usr/local/rust/src
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

alias tree='tree -F'
alias gl="git log --pretty=format:'%h - %an, %ar : %s'"
alias tn='tmux new -s'
alias ta='tmux a -t'
alias tl='tmux list-sessions'

case $(uname) in
  Linux)
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

load=(
  ~/.zshrc.local
  ~/.dotfiles/zsh/default
  ~/.dotfiles/zsh/completion
  ~/.dotfiles/zsh/history
  ~/.dotfiles/zsh/z
  ~/.fzf.zsh
  /usr/local/bin/virtualenvwrapper.sh
)
for file in $load; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done

fpath=("$HOME/.dotfiles/zsh" $fpath)
autoload -U colors && colors
autoload -Uz promptinit && promptinit
prompt "dqminh"
