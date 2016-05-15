#!/bin/bash
set -e

GOVERSION=1.6.2

cmd=$1
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
fi

if [[ $platform == 'linux' ]]; then
  if [[ $cmd == 'install' ]]; then
    sudo apt-get update && sudo apt-get install -y \
      build-essential \
      curl \
      wget \
      htop \
      make \
      git \
      mercurial \
      tmux \
      vim

    # install go
    (
      wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz && \
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz && \
        rm -rf /tmp/go.tar.gz
    )
  fi
fi

mkdir -p $HOME/gocode
mkdir -p $HOME/workspace

for entry in vim vimrc zsh_profile zshrc tmux.conf gitconfig gitignore; do
  rm -rf $HOME/.$entry && ln -s $HOME/.dotfiles/$entry $HOME/.$entry
done
