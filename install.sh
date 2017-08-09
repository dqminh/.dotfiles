#!/bin/bash
set -e

CUR=$(pwd)
NOOP=${NOOP:-false}
GO_VERSION=1.8.3
RUST_VERSION=1.19.0
POLYBAR_VERSION=3.0.5
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
system_link() { [[ ! -r $2 ]] && srun ln -sf $CUR/$1 $2 ; }

# sets up apt sources
# assumes you are going to use debian stretch
apt_sources() {
	srun apt-get update
	srun apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		wget \
		--no-install-recommends

	cat <<-EOF | sudo tee /etc/apt/sources.list.d/laptop.list
# git
deb http://ppa.launchpad.net/git-core/ppa/ubuntu zesty main
deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu zesty main

deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu xenial main
deb-src http://ppa.launchpad.net/neovim-ppa/stable/ubuntu xenial main

deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client zesty main

deb https://dl.google.com/linux/chrome/deb/ stable main

deb [arch=amd64] https://download.docker.com/linux/ubuntu zesty stable

deb https://packages.cloud.google.com/apt cloud-sdk-sid main
EOF

	# Import the Google Cloud Platform public key
	srun sh -c "curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"
	# Import the Google Chrome public key
	srun sh -c "curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add -"
	# add docker gpg key
	srun apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
	# add the git-core ppa gpg key
	srun apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24

	# add the neovim ppa gpg key
	srun apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 9DBB0BE9366964F134855E2255F96FCF8231B6DD

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
		gnupg \
		gnupg-agent \
		gnupg2 \
		google-chrome-stable \
		google-cloud-sdk \
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
		python3 \
		python3-pip \
		ranger \
		s3cmd \
		scdaemon \
		ssh \
		strace \
		sudo \
		tar \
		tree \
		tzdata \
		unzip \
		xclip \
		xz-utils \
		zip \
        cmake \
        mercurial \
        pkg-config \
		--no-install-recommends

	srun apt-get install -y \
		feh \
		i3blocks \
		scrot \
		compton \
		suckless-tools \
		--no-install-recommends

	# install tlp with recommends
	srun apt-get install -y tlp tlp-rdw

	srun apt-get autoremove
	srun apt-get autoclean
	srun apt-get clean

	# setup groups
	srun adduser "$USER" sudo
	srun adduser "$USER" docker
	srun adduser "$USER" systemd-journal

	srun wget https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` -O /usr/local/bin/docker-compose
	srun chmod +x /usr/local/bin/docker-compose

	# setup persistent journal
	srun mkdir -p /var/log/journal

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

go_pkg() {
	export GOPATH=/home/dqminh
	run go get github.com/golang/lint/golint
	run go get golang.org/x/tools/cmd/cover
	run go get golang.org/x/review/git-codereview
	run go get golang.org/x/tools/cmd/goimports
	run go get golang.org/x/tools/cmd/gorename
	run go get golang.org/x/tools/cmd/guru
	run go get github.com/nsf/gocode
	run go get github.com/rogpeppe/godef
	run go get github.com/shurcooL/markdownfmt
}

fonts_install() {
	mkdir -p $HOME/.local/share/fonts
	link fonts .local/share/fonts
	fc-cache -fv
}

config_install() {
	declare -A configs=(
	["gnupg/gpg.conf"]=".gnupg/gpg.conf"
	["gnupg/gpg-agent.conf"]=".gnupg/gpg-agent.conf"
	[".gitconfig"]=".gitconfig"
	[".gitignore"]=".gitignore"
	[".tmux.conf"]=".tmux.conf"
	[".zshrc"]=".zshrc"
	[".zsh"]=".zsh"
	[".Xresources"]=".Xresources"
	[".Xresources"]=".Xdefaults"
	[".Xmodmap"]=".Xmodmap"
	["nvim/autoload/plug.vim"]=".config/nvim/autoload/plug.vim"
	["nvim/init.vim"]=".config/nvim/init.vim"
	["i3/config"]=".config/i3/config"
	["i3status/config"]=".config/i3status/config"
	["compton/compton.conf"]=".config/compton.conf"
	["user/systemd"]=".config/systemd/user"
	["themes/gtk-3.0/gtk.css"]=".config/gtk-3.0/gtk.css"
	)

	run mkdir -p $HOME/.config/nvim
	run mkdir -p $HOME/.config/nvim/autoload
	run mkdir -p $HOME/.config/i3
	run mkdir -p $HOME/.config/i3status
	run mkdir -p $HOME/.config/systemd
	run mkdir -p $HOME/.config/gtk-3.0

	for name in "${!configs[@]}"; do
		link $name ${configs[$name]}
	done
}

system_config_install() {
	declare -A configs=(
	["themes/hybrid.theme"]="/usr/share/xfce4/terminal/colorschemes/hybrid.theme"
	["etc/systemd/logind.conf"]="/etc/systemd/logind.conf"
	["etc/systemd/system/notify_osd.service"]="/etc/systemd/system/notify_osd.service"
	["etc/systemd/system/i3lock@.service"]="/etc/systemd/system/i3lock@.service"
	["etc/systemd/system/firewall.service"]="/etc/systemd/system/firewall.service"
	["etc/udev/rules.d/70-rename-net-devices.rules"]="/etc/udev/rules.d/70-rename-net-devices.rules"
	["etc/X11/xorg.conf.d/50-synaptics-clickpad.conf"]="/etc/X11/xorg.conf.d/50-synaptics-clickpad.conf"
	)

	srun mkdir -p /etc/systemd/system
	srun mkdir -p /usr/share/xfce4/terminal/colorschemes
	srun mkdir -p /etc/udev/rules.d
	srun mkdir -p /etc/X11/xorg.conf.d

	for name in "${!configs[@]}"; do
		system_link $name ${configs[$name]}
	done

	srun systemctl enable firewall
	srun systemctl enable notify_osd
	srun systemctl enable i3lock@dqminh
}

usage() {
	echo "Usage:"
	echo "  apt     - setup packages"
	echo "  config  - setup config files"
	echo "  sconfig - setup system config files"
	echo "  golang  - setup go and packages"
	echo "  polybar - install polybar"
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
		sconfig)
			( system_config_install )
			;;
		go)
			( go_install )
			( go_pkg )
			;;
		rust)
			( rust_install )
			( rust_pkg )
			;;
		polybar)
			( polybar_install )
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
