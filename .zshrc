bindkey -e # use emacs mode explicitly
# do not print out garbage in gnome-terminal when copy-paste
set -g set-clipboard off
# interactive comment
set -k
setopt clobber

# Make neovim the default editor
export EDITOR=nvim

export CLICOLOR=1
export GOPATH=$HOME
export PATH=$HOME/bin:$HOME/.bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/go/bin:/usr/local/sbin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=50000000;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";

# golang
if [[ "$(pwd)" == "$HOME/go" || "$(pwd)" == "$HOME/go/*" ]]; then
  export GOPATH=$HOME/go
else
  export GOPATH=$HOME
fi

# BASE16_SHELL=$HOME/.config/base16-shell
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && source "$BASE16_SHELL/profile_helper.sh"

load=(
  ~/.zshrc.local
  ~/.zsh/completion
  ~/.zsh/default
  ~/.zsh/history
  ~/.zsh/z
  ~/.fzf.zsh
  ~/.zsh/prompt_dqminh_setup
)
for file in $load; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done

fpath=("$HOME/.zsh" $fpath)
autoload -U colors && colors
autoload -Uz promptinit && promptinit
autoload -Uz add-zsh-hook
prompt "dqminh"

alias tree='tree -F'

alias gl="git log --pretty=format:'%h - %an, %ar : %s'"

alias tn='tmux new -s'
alias ta='tmux a -t'
alias tl='tmux list-sessions'

alias ls='ls -lh --color=auto'
alias vi='nvim'
alias vim='nvim'

if [[ "$(uname)" = "Linux" ]]; then
  alias pbcopy='xclip -i -sel clip > /dev/null'
  alias pbpaste='xclip -o -sel clip'
  alias open='xdg-open'
fi

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"
alias bazel="bazelisk"

export PATH="$PATH:${HOME}/workspace/depot_tools"
export CDPATH=~/workspace:$CDPATH

[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# opam
[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

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

function socks5() {
  if [ "${1}" = "" ]; then
    echo "Usage: 'socks5 stop' or 'socks5 <endpoint>'" 1>&2
  elif [ "${1}" = "stop" ]; then
    ssh -S ~/.ssh/socks5.sock -O exit whatever
  else
    if [ -e ~/.ssh/socks5.sock ]; then
      echo "already connected, stop existing connection first" 1>&2
    else
      ssh -M -S ~/.ssh/socks5.sock -D 127.0.0.1:6666 -f -q -N "${1}"
    fi
  fi
}

function chrome-proxy() { nohup google-chrome --proxy-server 127.0.0.1:6666 2>&1 >/dev/null & }

function datenow() { date -u +%Y-%m-%dT%H:%M:%SZ }

function git_apocalypse() {
  read -q "REPLY?This reset your git state. Are you sure ?: "
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    git stash
    git submodule foreach --recursive git clean -fd
    git reset --hard
    git submodule foreach --recursive git reset --hard
    git submodule update --init --recursive
  fi
}
