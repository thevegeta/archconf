# Check for an interactive session
[ -z "$PS1" ] && return

# base-files version 3.9-3

# To pick up the latest recommended .bashrc content,
# look in /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# Environment Variables
# #####################
export EDITOR="vim"

# Shell Options
# #############
# Cygwin
if [ -n "$OS" ] && [ "$OS" = "Windows_NT" ]
then
    export DISPLAY=:0.0
    export TRAVAIL="/cygdrive/c/Travail"
    unset TMP
    unset TEMP
    export TEMP=/tmp
fi

# See man bash for more options...

# Don't wait for job termination notification
# set -o notify

# Don't use ^D to exit
# set -o ignoreeof

# Use case-insensitive filename globbing
# shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell


# Completion options
# ##################

# These completion tuning parameters change the default behavior of bash_completion:

# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
case $- in
  *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
esac

# Avoid the break of completion on variables using cd.
complete -r cd

# History Options
# ###############

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoredups"

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:l:ll:lla' # Ignore the ls command as well

# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"

# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
alias grep='grep -n --color'                    # show differences in colour
alias egrep='egrep -n --color'                  # show differences in colour

# Aliases
alias ll='ls -hlF'
alias la='ls -CAF'
alias lla='ls -hlAF'
alias l='ls -CF'
alias ls='ls --color=auto'

#other aliases
system=`uname -a`
case ${system,,} in
    *"ubuntu"*)
        alias update='sudo apt-get update && sudo apt-get upgrade'
        ;;
    *)
        alias yupdate='sudo yaourt -Syu'
        alias update='sudo pacman -Syu'
        ;;
esac
alias givm='gvim'

# set a fancy prompt
if [ -n "$SSH_CLIENT" ] ; then
    PS1="\[\e[01;31m\]\u@\h \[\e[01;34m\]\w\[\e[00m\]\n\$ "
else
    PS1="\[\e[01;32m\]\u@\h \[\e[01;34m\]\w\[\e[00m\]\n\$ "
fi


# Less and man colors.
export LESS_TERMCAP_mb=$'\E[01;31m'    # debut de blink !
export LESS_TERMCAP_md=$'\E[01;31m'    # debut de gras
export LESS_TERMCAP_me=$'\E[0m'        # fin
export LESS_TERMCAP_so=$'\E[01;44;33m' # début de la ligne d'état
export LESS_TERMCAP_se=$'\E[0m'        # fin
export LESS_TERMCAP_us=$'\E[01;32m'    # début de souligné
export LESS_TERMCAP_ue=$'\E[0m'        # fin

# Function to retrieve a word in c files and headers.
grepc()
{
    find . -name "*.[ch]" | xargs grep -n --color $1
}

# Get the history on a SVN repo for a user.
# $1 the user,
# $2 the repo.
svn_hist()
{
    svn log -v $2 | sed -n '/| '$1' |/,/-----$/ p'
}

