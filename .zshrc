bindkey -e # use emacs mode explicitly
# do not print out garbage in gnome-terminal when copy-paste
set -g set-clipboard off
# interactive comment
set -k
setopt clobber

# BASE16_SHELL=$HOME/.config/base16-shell
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && source "$BASE16_SHELL/profile_helper.sh"

load=(
  ~/.zshrc.local
  ~/.zsh/alias
  ~/.zsh/completion
  ~/.zsh/default
  ~/.zsh/functions
  ~/.zsh/personal
  ~/.zsh/history
  ~/.zsh/z
  ~/.fzf.zsh
  ~/.zsh/prompt_dqminh_setup
  /usr/bin/virtualenvwrapper.sh
  ~/.local/bin/virtualenvwrapper.sh
  ~/.bazel/bin/bazel-complete.bash
  ~/.zsh-histdb/sqlite-history.zsh
  ~/.zsh-histdb/histdb-interactive.zsh
)
for file in $load; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done

fpath=("$HOME/.zsh" $fpath)
autoload -U colors && colors
autoload -Uz promptinit && promptinit
autoload -Uz add-zsh-hook
prompt "dqminh"

# https://github.com/larkery/zsh-histdb reverse isearch
bindkey '^r' _histdb-isearch

export PATH="$PATH:${HOME}/workspace/depot_tools"

if [[ $TILIX_ID ]]; then
	source /etc/profile.d/vte.sh
fi

# direnv
eval "$(direnv hook zsh)"

# opam
[[ ! -r /home/dqminh/.opam/opam-init/init.zsh ]] || source /home/dqminh/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
