#!/bin/bash
set -e

CUR=$(pwd)
NOOP=${NOOP:-false}
GO_VERSION=1.12.7
RUST_VERSION=1.30.1
NEOVIM_VERSION=0.3.0
DOCKER_COMPOSE_VERSION=1.23.1
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

link() { run ln -sf $CUR/$1 $HOME/$2 ; }
slink() { srun ln -sf $CUR/$1 $HOME/$2 ; }
scopy() { srun rm -f $2 && srun cp $CUR/$1 $2 ; }

# sets up apt sources
# assumes you are going to use debian stretch
apt_sources() {
 	srun apt-get update
 	srun apt-get install -y \
 		software-properties-common \
 		curl \
 		wget \
 		--no-install-recommends

	cat <<-EOF | sudo tee /etc/apt/sources.list.d/laptop.list
deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main
deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-6.0 main
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-6.0 main
EOF

	# Import the Google Chrome public key
	srun sh -c "curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add -"
	# add docker gpg key
	srun sh -c "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -"
	# add llvm
	srun sh -c "wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -"

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
		openconnect \
		pinentry-curses \
		python \
		python-pip \
		python-setuptools \
		python3 \
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
		--no-install-recommends

	srun apt-get install -y clang-6.0 clang-tools-6.0 clang-6.0-doc libclang-common-6.0-dev \
		libclang-6.0-dev libclang1-6.0 libllvm6.0 lldb-6.0 llvm-6.0 \
		llvm-6.0-dev llvm-6.0-doc llvm-6.0-examples llvm-6.0-runtime clang-format-6.0 \
		python-clang-6.0 \
		--no-install-recommends

	srun apt-get autoremove
	srun apt-get autoclean
	srun apt-get clean

	# setup groups
	srun adduser "$USER" sudo
	srun adduser "$USER" docker
	srun adduser "$USER" systemd-journal

	srun wget https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -O /usr/local/bin/docker-compose
	srun chmod +x /usr/local/bin/docker-compose

	# setup persistent journal
	srun mkdir -p /var/log/journal

	srun ufw enable

	pip install neovim
	pip3 install neovim
}

rust_install() {
	[[ `$HOME/.cargo/bin/rustc --version` =~ "${RUST_VERSION}" ]] && return 0
	run sh -c "curl https://sh.rustup.rs -sSf | sh"
}

rust_pkg() {
	run /home/dqminh/.cargo/bin/cargo install ripgrep
}

go_install() {
	[[ `/usr/local/go/bin/go version` =~ "go${GO_VERSION}" ]] && return 0
	srun rm -rf /usr/local/go
	srun wget https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz
	srun tar -C /usr/local -xzf /tmp/go.tar.gz
	srun rm -rf /tmp/go.tar.gz
	srun chown -R dqminh /usr/local/go
}

neovim_install() {
	srun rm -rf /usr/local/bin/nvim
	srun wget https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim.appimage -O /usr/local/bin/nvim
	srun chmod +x /usr/local/bin/nvim
	srun update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 60
	srun update-alternatives --auto vi
	srun update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 60
	srun update-alternatives --auto vim
	srun update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 60
	srun update-alternatives --auto editor
}

neovim_pkg() {
	srun apt update
	srun apt install python-neovim python3-neovim
}

go_pkg() {
	export GOPATH=/home/dqminh
	run go get golang.org/x/lint
	run go get golang.org/x/tools/cmd/cover
	run go get golang.org/x/review/git-codereview
	run go get golang.org/x/tools/cmd/goimports
	run go get golang.org/x/tools/cmd/gorename
	run go get golang.org/x/tools/cmd/guru
	run go get github.com/mdempsky/gocode
	run go get github.com/rogpeppe/godef
	run go get github.com/shurcooL/markdownfmt
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
	["nvim/autoload/plug.vim"]=".config/nvim/autoload/plug.vim"
	["nvim/init.vim"]=".config/nvim/init.vim"
	)

	run mkdir -p $HOME/.config/nvim
	run mkdir -p $HOME/.config/nvim/autoload

	for name in "${!configs[@]}"; do
		link $name ${configs[$name]}
	done
}

themes_install() {
	mkdir -p ~/.config
	git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
}

usage() {
	echo "Usage:"
	echo "  apt     - setup packages"
	echo "  config  - setup config files"
	echo "  golang  - setup go and packages"
	echo "  rust    - setup rust and packages"
	echo "  fonts   - setup fonts"
	echo "  themes  - setup some themes"
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
		neovim)
			( neovim_install )
			( neovim_pkg )
			;;
		rust)
			( rust_install )
			( rust_pkg )
			;;
		fonts)
			( fonts_install )
			;;
		themes)
			( themes_install )
			;;
		*)
			usage
			;;
	esac
}

main "$@"
