bindkey -e # use emacs mode explicitly
# do not print out garbage in gnome-terminal when copy-paste
set -g set-clipboard off

load=(
  ~/.zshrc.local
  ~/.zsh/alias
  ~/.zsh/completion
  ~/.zsh/default
  ~/.zsh/export
  ~/.zsh/functions
  ~/.zsh/history
  ~/.zsh/z
  ~/.fzf.zsh
  ~/.zsh/prompt_dqminh_setup
  ~/.local/bin/virtualenvwrapper.sh
  ~/.bazel/bin/bazel-complete.bash
  # ~/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh
)
for file in $load; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done

fpath=("$HOME/.zsh" $fpath)
autoload -U colors && colors
autoload -Uz promptinit && promptinit
prompt "dqminh"

if [[ $TILIX_ID ]]; then
	source /etc/profile.d/vte.sh
fi
