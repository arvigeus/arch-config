# Manually reload bashrc: source ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines in the history.
HISTCONTROL=ignoredups

# Autocomplete: commands which have more than one possible completion cause the matches to be listed
set show-all-if-ambiguous on

alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -c -h'
alias dmesg='dmesg -HL'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias cls='printf "\033c" && clear && echo -en "\e[3J"'

export PATH="$HOME/.local/bin:$PATH"
export $(envsubst < ~/.env)
# [ -f .env ] && export $(envsubst < .env)