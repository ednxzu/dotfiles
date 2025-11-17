#! /bin/bash

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# always use bat
alias cat='bat'

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

# ip should always have colors (it's pretty)
alias ip='ip -c'

# some packages manager aliases
alias apt-get='sudo apt-get'
alias apt='sudo apt'
alias nala='sudo nala'
alias pacman='sudo pacman --config $HOME/.config/pacman.conf'
alias yay='yay --config $HOME/.config/pacman.conf'

# colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# humanly readable mount command
alias mount='mount | column -t'

# make codium be code
alias code='codium'

# gitlab-ci-local but shorter
alias gcl='gitlab-ci-local'
