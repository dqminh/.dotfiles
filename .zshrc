bindkey -e # use emacs mode explicitly
# do not print out garbage in gnome-terminal when copy-paste
set -g set-clipboard off
# interactive comment
set -k
setopt clobber

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

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
)
for file in $load; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done

fpath=("$HOME/.zsh" $fpath)
autoload -U colors && colors
autoload -Uz promptinit && promptinit
prompt "dqminh"

export PATH="$PATH:${HOME}/workspace/depot_tools"

if [[ $TILIX_ID ]]; then
	source /etc/profile.d/vte.sh
fi

conda() {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dqminh/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dqminh/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dqminh/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dqminh/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
}

# direnv
eval "$(direnv hook zsh)"
