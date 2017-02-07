bindkey -e # use emacs mode explicitly

# User configuration
export EDITOR='vim'
export GOPATH=$HOME
export PATH=$HOME/bin:$HOME/.bin:$HOME/.cargo/bin:/usr/local/go/bin:/usr/local/sbin:$PATH
export RUST_SRC_PATH=/usr/local/rust/src
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
source $HOME/.cargo/env

alias tree='tree -F'
alias gl="git log --pretty=format:'%h - %an, %ar : %s'"
alias tn='tmux new -s'
alias ta='tmux a -t'
alias tl='tmux list-sessions'
alias pbcopy='xclip -i -sel clip > /dev/null'
alias pbpaste='xclip -o -sel clip'
alias ls='ls -lah --color=auto'
alias open='xdg-open'
alias vi='nvim'
alias vim='nvim'

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
