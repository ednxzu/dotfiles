#! /bin/bash

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# see mounted drives only
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

# unpack a tar archive
alias untar='tar -zxvf'

# download with + resume
alias wget='wget -c'

# checksum
alias sha='shasum -a 256 '

# ping but it stops at 5
alias ping='ping -c 5'

# some packages manager aliases
alias apt-get='sudo apt-get'
alias apt='sudo apt'
alias nala='sudo nala'

# colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# humanly readable mount command
alias mount='mount | column -t'

# ensure ssh does not break because of alacritty
alias ssh='TERM=xterm-256color ssh'
