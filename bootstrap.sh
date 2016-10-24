#!/bin/bash
set -e

GO_VERSION=go1.7.2
NEOVIM_VERSION=0.1.5

cmd_exists() {
  type "$1" &> /dev/null
}

install_apt() {
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    software-properties-common

  # neovim ppa
  sudo add-apt-repository ppa:neovim-ppa/unstable

  # docker
  sudo tee /etc/apt/sources.list.d/docker.list <<EOF
deb https://apt.dockerproject.org/repo ubuntu-xenial main
EOF

  # add docker pgp key
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
}

install_packages() {
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y --no-install-recommends \
    apparmor \
    automake \
    bash-completion \
    bc \
    build-essentials \
    bridge-utils \
    bzip2 \
    cgroupfs-mount \
    coreutils \
    curl \
    dnsutils \
    file \
    findutils \
    gcc \
    git \
    gnupg \
    grep \
    gzip \
    hostname \
    indent \
    iptables \
    jq \
    less \
    libapparmor-dev \
    libc6-dev \
    libltdl-dev \
    htop \
    libseccomp-dev \
    locales \
    lsof \
    make \
    mount \
    net-tools \
    network-manager \
    network-manager-openconnect \
    network-manager-openconnect-gnome \
    openconnect \
    openvpn \
    python \
    python-pip \
    python-setuptools \
    python3 \
    python3-pip \
    python3-setuptools \
    s3cmd \
    scdaemon \
    silversearcher-ag \
    ssh \
    strace \
    sudo \
    tar \
    tmux \
    tree \
    tzdata \
    unzip \
    xsel \
    xz-utils \
    zip \
    zsh

  sudo apt-get install -y docker-engine
  sudo apt-get install -y neovim

  sudo apt-get autoremove
  sudo apt-get autoclean

  # install neovim python client
  pip2 install --upgrade pip
  pip2 install --upgrade --user setuptools wheel neovim
  pip3 install --upgrade pip
  pip3 install --upgrade --user setuptools wheel neovim

  sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
  sudo update-alternatives --auto vi
  sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
  sudo update-alternatives --auto vim
  sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
  sudo update-alternatives --auto editor

  # install system-wide systemd services
  sudo mkdir -p /etc/systemd/system/docker.service.d
  sudo ln -sf ~/.dotfiles/etc/systemd/system/docker.service.d/override.conf \
    /etc/systemd/system/docker.service.d/override.conf

  sudo systemctl daemon-reload
  sudo systemctl restart docker
}

install_user() {
  sudo gpasswd -a dqminh sudo
  sudo gpasswd -a dqminh systemd-journal
  sudo gpasswd -a dqminh systemd-network
  sudo gpasswd -a dqminh docker

  chsh -s /bin/zsh

  # add go path to secure path
  sudo tee -a /etc/sudoers <<EOF
Defaults secure_path="/usr/local/go/bin:/home/dqminh/gocode/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
Defaults env_keep += "ftp_proxy http_proxy https_proxy no_proxy GOPATH EDITOR"
EOF
}

install_go() {
  if cmd_exists "go"; then
    local version=$(go version | cut -d' ' -f3)
    if [[ "$version" == "$GO_VERSION" ]]; then
      echo "go: $GO_VERSION is installed"
      return 0
    fi
  fi
  sudo rm -rf /usr/local/go
  wget https://storage.googleapis.com/golang/${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz
  sudo tar -C /usr/local -xzf /tmp/go.tar.gz
  rm -rf /tmp/go.tar.gz

  for binary in /usr/local/go/bin/*; do
    sudo ln -sf $binary /usr/local/bin/$(basename $binary)
  done
}

install_config() {
  local configs=(
  zsh_profile
  zshrc
  tmux.conf
  gitconfig
  gitignore
  Xmodmap
  )

  for conf in "${configs[@]}"; do
    echo "installing .$conf"
    rm -rf $HOME/.$conf
    ln -sf $HOME/.dotfiles/$conf $HOME/.$conf
  done

  # install neovim configuration
  mkdir -p ~/.config/nvim
  ln -sf ~/.dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
  ln -sf ~/.dotfiles/config/nvim/init.vim ~/.vimrc
  ln -sf ~/.dotfiles/config/nvim/autoload ~/.config/nvim/autoload

  # install system service
  local system_services=(
  apple-hid
  )
  for service in "${system_services[@]}"; do
    sudo ln -sf ~/.dotfiles/etc/systemd/system/$service.service /etc/systemd/system/$service.service
  done
  sudo systemctl daemon-reload
  for service in "${system_services[@]}"; do
    sudo systemctl enable $service
    sudo systemctl start $service
  done

  # install user service
  mkdir -p ~/.config/systemd/user
  local services=(
  xmodmap
  ssh-agent
  )
  for service in "${services[@]}"; do
    ln -sf ~/.dotfiles/config/systemd/user/$service.service ~/.config/systemd/user/$service.service
  done

  systemctl --user daemon-reload
  for service in "${services[@]}"; do
    systemctl --user enable $service
    systemctl --user start $service
  done
}

install_fonts() {
  rm -rf ~/.fonts
  ln -sf ~/.dotfiles/fonts ~/.fonts
  fc-cache -fv
}

install_ubuntu() {
  sudo apt-add-repository ppa:tista/adapta
  sudo add-apt-repository ppa:snwh/pulp
  sudo apt-get update
  sudo apt-get install -y \
    unity-tweak-tool \
    numix-gtk-theme \
    numix-icon-theme \
    breeze-icon-theme \
    arc-theme \
    adapta-gtk-theme \
    paper-icon-theme \
    paper-cursor-theme
    # paper-gtk-theme
}

main() {
  mkdir -p $HOME/gocode
  mkdir -p $HOME/workspace
  local cmd=$1

  if [[ $cmd == 'apt' ]]; then
    ( install_apt )
  elif [[ $cmd == 'install' ]]; then
    ( install_go )
    ( install_packages )
    ( install_user )
  elif [[ $cmd == 'ubuntu' ]]; then
    if cmd_exists "lsb_release"; then
      local distro=$(lsb_release -i | awk '{print $3}')
      if [[ $distro == "Ubuntu" ]]; then
        ( install_ubuntu )
      fi
    fi
  elif [[ $cmd == 'config' ]]; then
    ( install_config )
  elif [[ $cmd == 'fonts' ]]; then
    ( install_fonts )
  fi
}

main "$@"
