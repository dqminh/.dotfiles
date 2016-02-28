#!/bin/bash
set -e

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
      wget https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz -O /tmp/go.tar.gz && \
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz && \
        rm -rf /tmp/go.tar.gz
    )
  fi
fi

mkdir -p $HOME/gocode
mkdir -p $HOME/workspace

rm -rf $HOME/.vim && ln -s $HOME/.dotfiles/vim $HOME/.vim
rm -rf $HOME/.vimrc && ln -s $HOME/.dotfiles/vimrc $HOME/.vimrc
rm -rf $HOME/.bash_profile && ln -s $HOME/.dotfiles/bash_profile $HOME/.bash_profile
rm -rf $HOME/.bashrc && ln -s $HOME/.dotfiles/bashrc $HOME/.bashrc
rm -rf $HOME/.tmux.conf && ln -s $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
rm -rf $HOME/.gitconfig && ln -s $HOME/.dotfiles/gitconfig $HOME/.gitconfig
rm -rf $HOME/.gitignore && ln -s $HOME/.dotfiles/gitignore $HOME/.gitignore


if [[ $platform == 'linux' ]]; then
  rm -rf $HOME/.profile && ln -s $HOME/.dotfiles/profile.linux $HOME/.profile
fi
