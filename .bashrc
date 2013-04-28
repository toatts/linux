#
# ~/.bashrc
#

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias rm='rm -i'
alias df='df -h'
alias h='history|grep'
alias vi="/usr/bin/vim"
alias p='ps -ef|grep'
alias update='sudo pacman -Syu'
alias download='sudo pacman -S'
alias upgrade='sudo pacman -U'
alias extract='tar -xzf'


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim

# Terminal Prompt Settings
# Color Codes with tput
# 0 = Black
# 1 = Red
# 2 = Green 
# 3 = Yellow
# 4 = Blue
# 5 = Magenta
# 6 = Cyan
# 7 = White
# tput options
# setab - background color, setaf - foreground color
# bold - bold, dim - half-bright, smul - underline
# rmul - end underline, rev - reverse mode, 
# smso - standout mode, rmso - end standout mode
# sgr0 - turn off all attributes
export PS1="\
\[$(tput setaf 6)\][\d \@] \
\[$(tput smul)\]\
\[$(tput setaf 1)\]\u@\h\
\[$(tput rmul)\]: \[$(tput setaf 3)\]\w> \
\[$(tput sgr0)\]"

tarview() {
    if [ -e $1 ]
    then
        echo -n "Displaying contents of $1"
        if [ ${1##*.} = tar ]
            then
            echo "(uncompressed tar)"
            tar tvf $1
        elif [ ${1##*.} = gz ]
            then
            echo "(gzip-compressed tar)"
            tar tzvf $1
        elif [ ${1##*.} = bz2 ]
            then
            echo "(bzip2-compressed tar)"
            cat $1 | bzip2 -d | tar tvf -
        fi
    else
        echo "file \"$1\" doesn't exist"
    fi
}
