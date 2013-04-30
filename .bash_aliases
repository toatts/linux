# .bash_aliases

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias h='history|grep'
alias fpga_ftp='ftp 10.88.5.42'
alias g='gvim --remote-silent'
alias gcc='gcc -Wall -std=c99 -pedantic'
alias spath='pushd .'
alias lpath='popd'
alias lbash='source ~/.bashrc'

# Current Processes
alias p='ps -ef|grep'
alias pvnc='ps -ef|grep vnc'
alias psyn='ps -ef|grep syn'

# VNC
alias initvnc='vncserver :52 -geometry 1650x1000 -depth 24'
alias killvnc='vncserver -kill :52'
alias initvncwide='vncserver :37 -geometry 3250x1000 -depth 24'
alias killvncwide='vncserver -kill :37'
alias initlaptopvnc='vncserver :14 -geometry 1475x865'
alias killlaptopvnc='vncserver -kill :14'

# List Available Tools
alias tools='cd /corp/tools/fpga; ll'

#Grid Stats
alias gridload="qhost -F cpu"
alias gridjobs="qstat -f -r -u \*"

# 0in Liscenses
alias 0in_licenses='${HOME_0IN}/mgls/bin/lmstat -f zncompcdc'
alias hds_licenses='lmstat -f hdldesigner_c'
