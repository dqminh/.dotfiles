#!/bin/bash
set -e

CUR=$(pwd)
NOOP=${NOOP:-false}
GO_VERSION=1.19.1
RUST_VERSION=1.63.0
USER=dqminh

command_exists () { type "$1" &> /dev/null; }

run() {
	local action=$1
	shift
	echo "run: $action $@"
	[[ "$NOOP" == "true" ]] && return 0
	$action "$@"
}
srun() { run sudo "$@" ; }

link() { run rm -rf $HOME/$2 && run ln -sf $CUR/$1 $HOME/$2 ; }
slink() { srun ln -sf $CUR/$1 $HOME/$2 ; }
scopy() { srun rm -f $2 && srun cp $CUR/$1 $2 ; }

# sets up apt sources
# assumes you are going to use debian-based distro
apt_sources() {
 	srun apt-get update
 	srun apt-get install -y \
		ca-certificates \
 		software-properties-common \
 		curl \
		gnupg \
		lsb-release \
 		wget \
 		--no-install-recommends

	# install docker
	srun mkdir -p /etc/apt/keyrings
	srun sh -c "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg"
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	# install neovim
	srun add-apt-repository ppa:neovim-ppa/stable

	# install nodejs
	curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - sudo apt-get install -y nodejs

	# turn off translations, speed up apt-get update
	srun mkdir -p /etc/apt/apt.conf.d
	srun sh -c "echo 'Acquire::Languages \"none\";' > /etc/apt/apt.conf.d/99translations"
}

apt_pkg() {
	srun apt-get update
	srun apt-get -y upgrade

	srun apt-get install -y \
		adduser \
		apparmor \
		automake \
		bash-completion \
		bc \
		bridge-utils \
		build-essential \
		bzip2 \
		ca-certificates \
		cgroupfs-mount \
		coreutils \
		curl \
		dnsutils \
		docker-ce \
		findutils \
		gcc \
		git \
		google-chrome-stable \
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
		neovim \
		net-tools \
		network-manager \
		luarocks \
		openconnect \
		pinentry-curses \
		python3 \
		python-is-python3 \
		python3-pip \
		python3-setuptools \
		s3cmd \
		scdaemon \
		ssh \
		strace \
		sudo \
		tar \
		tree \
		tzdata \
		tmux \
		unzip \
		xclip \
		xz-utils \
		zip \
		cmake \
		mercurial \
		pkg-config \
		ufw \
		neovim \
		docker-compose-plugin \
		--no-install-recommends

	srun apt-get install -y clang clang-tools libclang-dev libclang1 llvm clang-format \
		--no-install-recommends

	srun apt-get autoremove
	srun apt-get autoclean
	srun apt-get clean

	# setup groups
	srun adduser "$USER" sudo
	srun adduser "$USER" docker
	srun adduser "$USER" systemd-journal

	# setup persistent journal
	srun mkdir -p /var/log/journal

	# neovim is vim
	srun update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
	srun update-alternatives --auto vi
	srun update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
	srun update-alternatives --auto vim
	srun update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
	srun update-alternatives --auto editor

	srun ufw enable
}

rust_install() {
	[[ `$HOME/.cargo/bin/rustc --version` =~ "${RUST_VERSION}" ]] && return 0
	run sh -c "curl https://sh.rustup.rs -sSf | sh"
}

rust_pkg() {
	run /home/dqminh/.cargo/bin/cargo install ripgrep
	run sh -c "curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer"
	run chmod +x ~/.local/bin/rust-analyzer
}

go_install() {
	[[ `/usr/local/go/bin/go version` =~ "go${GO_VERSION}" ]] && return 0
	srun rm -rf /usr/local/go
	srun wget https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz
	srun tar -C /usr/local -xzf /tmp/go.tar.gz
	srun rm -rf /tmp/go.tar.gz
	srun chown -R dqminh /usr/local/go
}

go_pkg() {
	export GOPATH=/home/dqminh
	run go install golang.org/x/lint
	run go install golang.org/x/tools/cmd/cover
	run go install golang.org/x/review/git-codereview
	run go install golang.org/x/tools/cmd/goimports
	run go install golang.org/x/tools/cmd/gorename
	run go install golang.org/x/tools/cmd/guru
	run go install github.com/mdempsky/gocode
	run go install github.com/rogpeppe/godef
	run go install github.com/shurcooL/markdownfmt
	run go install github.com/jesseduffield/lazygit@latest
}

fonts_install() {
	mkdir -p $HOME/.local/share
	link fonts .local/share/fonts
	fc-cache -fv
}

config_install() {
	declare -A configs=(
	[".gitconfig"]=".gitconfig"
	[".gitignore"]=".gitignore"
	[".tmux.conf"]=".tmux.conf"
	[".zshrc"]=".zshrc"
	[".zsh"]=".zsh"
	["zsh-histdb"]=".zsh-histdb"
	["base16-shell"]=".config/base16-shell"
	["base16-tmux"]=".config/base16-tmux"
	["nvim/init.lua"]=".config/nvim/init.lua"
	)

	mkdir -p ~/.config/nvim

	for name in "${!configs[@]}"; do
		link $name ${configs[$name]}
	done
}

usage() {
	echo "Usage:"
	echo "  apt     - setup packages"
	echo "  config  - setup config files"
	echo "  golang  - setup go and packages"
	echo "  rust    - setup rust and packages"
	echo "  fonts   - setup fonts"
}

main() {
	local target=$1
	case $target in
		apt)
			( apt_sources )
			( apt_pkg )
			;;
		config)
			( config_install )
			;;
		go)
			( go_install )
			( go_pkg )
			;;
		rust)
			( rust_install )
			( rust_pkg )
			;;
		fonts)
			( fonts_install )
			;;
		*)
			usage
			;;
	esac
}

main "$@"
