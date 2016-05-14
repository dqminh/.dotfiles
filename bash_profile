for file in ~/.{bash_prompt,bashrc}; do
    [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null
done

case $(uname) in
  Linux)
    gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
    ;;
  Darwin)
    [ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
    if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
      export GPG_AGENT_INFO
    else
      eval $( gpg-agent --daemon --write-env-file ~/.gpg-agent-info )
    fi
    ;;
esac
