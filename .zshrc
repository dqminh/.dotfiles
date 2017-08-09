bindkey -e # use emacs mode explicitly
# do not print out garbage in gnome-terminal when copy-paste
set -g set-clipboard off

# User configuration
export EDITOR='nvim'
export CLICOLOR=1
export GOPATH=$HOME
export PATH=$HOME/bin:$HOME/.bin:$HOME/.cargo/bin:/usr/local/go/bin:/usr/local/sbin:$PATH
export RUST_SRC_PATH=/usr/local/rust/src
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# kubernetes
export KUBECONFIG=/var/run/kubernetes/admin.kubeconfig
export PATH=$HOME/src/k8s.io/kubernetes/_output/local/bin/linux/amd64:$PATH
# Load the kubectl completion code for zsh[1] into the current shell
source <(kubectl completion zsh)

# golang
if [[ "$(pwd)" == "$HOME/go" || "$(pwd)" == "$HOME/go/*" ]]; then
  export GOPATH=$HOME/go
else
  export GOPATH=$HOME
fi

alias tree='tree -F'
alias gl="git log --pretty=format:'%h - %an, %ar : %s'"
alias tn='tmux new -s'
alias ta='tmux a -t'
alias tl='tmux list-sessions'
alias ls='ls -lh'
alias vi='vim'

alias pbcopy='xclip -i -sel clip > /dev/null'
alias pbpaste='xclip -o -sel clip'
alias open='xdg-open'

load=(
  ~/.zshrc.local
  ~/.zsh/default
  ~/.zsh/completion
  ~/.zsh/history
  ~/.zsh/z
  ~/.zsh/functions
  ~/.fzf.zsh
  ~/.zsh/prompt_dqminh_setup
  ~/.local/bin/virtualenvwrapper.sh
)
for file in $load; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done

fpath=("$HOME/.zsh" $fpath)
autoload -U colors && colors
autoload -Uz promptinit && promptinit
prompt "dqminh"
