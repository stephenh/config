#!/bin/sh

export PS1="[\u@\h \W]$ "
export LESS='-FXRS -x2'

alias ls='ls --color=auto -lh'
alias jstackall="ps -C java -o pid= | xargs -I {} -r sh -c 'echo PID={} && jstack {}'"
alias t='set_title.sh'
alias o=xdg-open
eval $(dircolors -b $HOME/.dircolors)

# Make .bash_history more useful
# http://blog.sanctum.geek.nz/better-bash-history/
shopt -s histappend
shopt -s cmdhist
HISTFILESIZE=100000000
HISTSIZE=100000000
HISTCONTROL=ignorespace:ignoredups:erasedups
HISTIGNORE='bg:fg:history:exit:d:s:b'

# git prompt integration
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \1/"
}
export PS1=$(echo "$PS1" | sed 's/\\W/\\W\\[\\033[1;34m\\]$(parse_git_branch)\\[\\033[0m\\]/')

# Include z
. ~/tools/z.sh

# shouldn't be needed due to .inputrc, but fzf config wants it
set -o vi
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source ~/.fzf.bash

# Set title to the current directory
# \033 == escape, \007 == bell
PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# After each command, append to the history file and reread it
# http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows#3055135
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# bell when a command completes. Ideally:
#
# * Bash echos a bell (control-a)
# * The terminal has "show urgent on bell" to convert the bell into X-Windows urgent hint
# * The window manager (i3wm) sees the urgent hint and flashes the window/workspace
#
# See https://faq.i3wm.org/question/203/how-to-set-the-urgency-hint-in-a-shell.1.html
#
# alias enable_alert='PROMPT_COMMAND="$PROMPT_COMMAND; echo -e '"'"'\a'"'"'"'
#
export PROMPT_COMMAND="$PROMPT_COMMAND; echo -e '\a'"

# added by travis gem
[ -f /home/stephen/.travis/travis.sh ] && source /home/stephen/.travis/travis.sh

# keychain
if [ -x /usr/bin/keychain ] ; then
  /usr/bin/keychain ~/.ssh/id_rsa ~/.ssh/bizo_dsa ~/.ssh/shaberma_at_linkedin.com_dsa_key
  . ~/.keychain/`hostname`-sh
fi
eval $(keychain --eval --quiet)

