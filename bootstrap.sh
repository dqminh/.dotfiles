#!/bin/bash
set -e

GO_VERSION=go1.7.2
NEOVIM_VERSION=0.1.5
TMUX_VERSION=2.2

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
		libseccomp-dev \
		locales \
		lsof \
		make \
		mount \
		net-tools \
		network-manager \
		network-manager-openconnect \
		openconnect \
		openvpn \
		s3cmd \
		scdaemon \
		silversearcher-ag \
		ssh \
		strace \
		sudo \
		tar \
		tree \
		tzdata \
		unzip \
		xsel \
		xz-utils \
		python \
		python-pip \


		zip

	sudo apt-get install -y tlp tlp-rdw
	sudo apt-get install -y docker-engine
	sudo apt-get install -y neovim

	sudo apt-get autoremove
	sudo apt-get autoclean

	# install neovim python client
	pip2 install --upgrade neovim
	pip3 install --upgrade neovim
}

install_user() {
	sudo gpasswd -a dqminh sudo
	sudo gpasswd -a dqminh systemd-journal
	sudo gpasswd -a dqminh systemd-network
	sudo gpasswd -a dqminh docker

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
configs=(
config
zsh_profile
zsh_rc
tmux.conf
gitconfig
gitignore
Xmodmap
)

for conf in $configs; do
	rm -rf $HOME/.$conf && ln -s $HOME/.dotfiles/$conf $HOME/.$conf
done
}

# # install go thing
# (
#   export PATH=/usr/local/go/bin:$PATH
#   export GOPATH=$HOME/gocode
#   export GOBIN=$HOME/gocode/bin
#   go get -u github.com/nsf/gocode
#   go get -u github.com/shurcooL/markdownfmt
#   go get -u github.com/pocke/lemonade
#   go get -u github.com/getantibody/antibody/cmd/antibody
# )
# 
# antibody bundle < bundles.txt >> zsh_bundle.sh
# for entry in config zsh_profile zshrc tmux.conf gitconfig gitignore; do
# done
# 
# if [[ $platform == 'darwin' ]]; then
# 	ln -sf $HOME/.dotfiles/LaunchAgents/local.lemonade.plist $HOME/Library/LaunchAgents/local.lemonade.plist
# 	launchctl load $HOME/Library/LaunchAgents/local.lemonade.plist
# fi

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
	elif [[ $cmd == 'config' ]]; then
	fi
}

main "$@"
