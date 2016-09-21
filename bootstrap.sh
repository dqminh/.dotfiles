#!/bin/bash
set -e

GO_VERSION=1.7.1
NEOVIM_VERSION=0.1.5
TMUX_VERSION=2.2

cmd=$1
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='darwin'
fi

# store external source code and dependencies for dev
mkdir $HOME/source

if [[ $platform == 'linux' ]]; then
  if [[ $cmd == 'install' ]]; then
    sudo apt-get update && sudo apt-get install -y \
      build-essential \
      curl \
      git \
      htop \
      libevent-dev \
      make \
      mercurial \
      ncurses-dev \
      python \
      python-pip \
      python3 \
      python3-pip \
      tmux \
      vim \
      wget

    # install go
    (
      rm -rf /usr/local/go
      wget https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz && \
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz && \
        rm -rf /tmp/go.tar.gz
    )

    # install tmux
    (
      rm -rf /usr/local/source/tmux
      wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz -O /tmp/tmux.tar.gz && \
        sudo tar -C $HOME/source/tmux -xzf /tmp/tmux.tar.gz && \
        cd $HOME/source/tmux && \
        configure && \
        make && \
        sudo ln -s $HOME/source/tmux/tmux /usr/local/bin/tmux
    )

    # install neovim
    (
      rm -rf /tmp/neovim
      wget https://github.com/neovim/neovim/archive/v${NEOVIM_VERSION}.tar.gz -O /tmp/neovim.tar.gz && \
        sudo tar -C /tmp/neovim -xzf /tmp/neovim.tar.gz && \
        cd /tmp/neovim && \
        make && \
        sudo make install && \
        cd /tmp && \
        rm -rf /tmp/neovim && \
        rm -rf /tmp/neovim.tar.gz
    )

    # install neovim python client
    sudo pip2 install --upgrade neovim
    sudo pip3 install --upgrade neovim

    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor
  fi
elif [[ $platform == 'darwin' ]]; then
  if [[ $cmd == 'install' ]]; then
    echo "installing python"
    brew install python
    brew install python3

    echo "installing neovim client for python"
    sudo pip2 install --upgrade neovim
    sudo pip3 install --upgrade neovim
    sudo ln -s /usr/local/bin/nvim /usr/local/bin/vi
    sudo ln -s /usr/local/bin/nvim /usr/local/bin/vim
  fi
fi

mkdir -p $HOME/gocode
mkdir -p $HOME/workspace

for entry in config zsh_profile zshrc tmux.conf gitconfig gitignore; do
  rm -rf $HOME/.$entry && ln -s $HOME/.dotfiles/$entry $HOME/.$entry
done

# install go thing
(
  export GOBIN=$HOME/gocode/bin
  go get -u github.com/nsf/gocode
  go get -u github.com/shurcooL/markdownfmt
)
