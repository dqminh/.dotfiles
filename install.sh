#!/bin/bash

CUR=$(pwd)
NOOP=${NOOP:-false}
GO_VERSION=1.8.3
RUST_VERSION=1.19.0

command_exists () { type "$1" &> /dev/null; }

run() {
	local action=$1
	shift
	if [[ "$NOOP" == "true" ]]; then
		echo "going to run: $action $@"
	else
		$action "$@"
	fi
}

srun() {
	run sudo "$@"
}

install::add_apt() {
    local deb=$1
    local key=$2
    local name=$3
    srun sh -c "echo $deb > /etc/apt/sources.list.d/$name.list"
    srun sh -c "wget -O - $key | apt-key add -"
}

install::apt() {
    srun apt-get update
    srun apt-get install -y "$@"
}

link() {
    local f=$1
    local to=${2-$f}
    local fn=$(basename $f)
    if [[ -r "$HOME/to" && -d "$HOME/$to" ]]; then
        run ln -sf $CUR/$f $HOME/$to/$fn
    else
        run ln -sf $CUR/$f $HOME/$to
    fi
}

lang::rust() {
	[[ `$HOME/.cargo/bin/rustc --version` =~ "${RUST_VERSION}" ]] && return 0
	run sh -c "curl https://sh.rustup.rs -sSf | sh"
}

lang::go() {
	[[ `/usr/local/go/bin/go version` =~ "go${GO_VERSION}" ]] && return 0
	srun rm -rf /usr/local/go
	srun wget https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz
	srun tar -C /usr/local -xzf /tmp/go.tar.gz
	srun rm -rf /tmp/go.tar.gz
	srun chown -R dqminh /usr/local/go
}

core() {
    install::apt \
		build-essential \
        git \
        mercurial \
        cmake \
        pkg-config \
		curl \
		openconnect \
		python \
		python3 \
		neovim \
		python-neovim \
		python3-neovim \
		xclip

	lang::rust
	lang::go

	srun mkdir -p /var/log/journal
}

apps::chrome() {
	command_exists "google-chrome" && return 0
	install::add_apt \
		"deb https://dl.google.com/linux/chrome/deb/ stable main" \
		"https://dl.google.com/linux/linux_signing_key.pub" \
		google-chrome
	install::apt google-chrome-stable
}

apps::hipchat() {
    command_exists "hipchat4" && return 0
    install::add_apt \
        "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" \
        "https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public" \
        hipchat4
    install::apt hipchat4
}

#apps::wm() {
#    sudo apt update
#    sudo apt install -y \
#        i3blocks \
#        rofi
#}

config::user() {
    local target=$1
    case $target in
		fonts)
			mkdir -p $HOME/.local/share/fonts
			link fonts .local/share/fonts
			fc-cache -fv
			;;
		config)
			link .gitconfig
			link .tmux.conf

			link .zshrc
			link .zsh

			mkdir -p $HOME/.config/nvim
			mkdir -p $HOME/.config/nvim/autoload
			link nvim/autoload/plug.vim .config/nvim/autoload
			link nvim/init.vim .config/nvim

			mkdir -p $HOME/.config/i3
			link .Xresources .Xresources
			link .Xresources .Xdefaults
			link i3/config .config/i3
			link i3/i3blocks.conf .config/i3
			;;
    esac
}

main() {
	local target=$1
	case $target in
		core)
			( core )
			;;
		apps)
			( apps::chrome )
			( apps::hipchat )
			;;
		config)
			( config::user config )
			;;
		fonts)
			( config::user fonts )
			;;
	esac
}

main "$@"
