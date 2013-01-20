# .bashrc
OS=`uname -s`

export COMMAND_MODE=unix2003
alias zcat='gunzip -c'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi`


# Colorize ls, less, more, grep
case "$OS" in
    "SunOS" ) 
        # Solaris ls doesn't allow color, so use special characters
        alias ls='ls -F'
        ;;
    "Linux" )
        # GNU ls supports colors!
        # See dircolors to customize colors
        export LS_OPTIONS='--color=auto' 
        alias ls='ls ${LS_OPTS}'

        # Get color support for 'less'
        export LESS="--RAW-CONTROL-CHARS"

        # Use colors for less, man, etc.
        [[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

        export GREP_OPTIONS="--color=auto"
        ;;
    "Darwin"|"FreeBSD")

        # Most FreeBSD & Apple Darwin supports colors
        export CLICOLOR=true

        # Get color support for 'less'
        export LESS="--RAW-CONTROL-CHARS -eX" 


# User specific aliases and functions

function ps1_git_status {
    local branch_color='\033[01;34m'
    local index_color='\033[01;32m'
    local modified_color='\033[01;31m'
    local untracked_color='\033[01;33m'
    local no_color='\033[0m'

    [[ -z $(which git 2>/dev/null) ]] && return

    local GIT_STATUS=$(/usr/bin/git status 2>/dev/null)
    [[ -z $GIT_STATUS ]] && return

    local GIT_BRANCH="$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
    if [[ "$GIT_BRANCH" == *'(no branch)'* ]]; then
        GIT_BRANCH='no branch'
    fi

    local GIT_STATE=''
    if [[ "$GIT_STATUS" != *'working directory clean'* ]]; then
        GIT_STATE=':'
        if [[ "$GIT_STATUS" == *'Changes to be committed:'* ]]; then
            GIT_STATE=$GIT_STATE"${index_color}I${no_color}"
        fi
        if [[ "$GIT_STATUS" == *'Changes not staged for commit'* ]]; then
            GIT_STATE=$GIT_STATE"${modified_color}M${no_color}"
        fi
        if [[ "$GIT_STATUS" == *'Untracked files:'* ]]; then
            GIT_STATE=$GIT_STATE"${untracked_color}U${no_color}"
        fi
    fi

    echo -ne " (${branch_color}${GIT_BRANCH}${no_color}${GIT_STATE})"
}

# Set colors for user
case `id -u` in
    0)  lcolor='\[\033[01;31m\]';;
    *)  lcolor='\[\033[01;32m\]';;
esac
hcolor='\[\033[01;33m\]'
nocolor='\[\033[0m\]'

# User specific aliases and functions
case "$TERM" in
    xterm*|rxvt*)
        # Set prompt
        PS1="${lcolor}\u${nocolor}@${hcolor}dev${nocolor}:\w\$(ps1_git_status)\\\$ "
        # Set terminal title
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@$HOSTNAME: ${PWD/$HOME/~}\007"'
        ;;
    *)
        ;;
esac

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi



