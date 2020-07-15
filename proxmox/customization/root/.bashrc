# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# BASH configuration
alias bashconfig='vim ~/.bashrc'
alias bashreload='. ~/.bashrc'

# Hosts and Hostname configuration
alias confighosts='vim /etc/hosts'
alias confighostname='vim /etc/hostname'

# SSH Configuration
alias sshconfig='vim ~/.ssh/config'
alias sshdconfig='vim /etc/ssh/sshd_config'

# Update the system
function update {
apt-get update &&
apt-get full-upgrade -Vy &&
apt-get autoremove -y &&
 apt-get autoclean &&
 apt-get clean
}

# Reboot / Halt / Poweroff
alias reboot=' reboot'
alias poweroff=' poweroff'
alias halt='halt'
alias shutdown'shutdown'

# Remove files or directories
alias rm='rm -rv'
# Copy directories recursively 
alias cp='cp -rv'
# Move files or directories 
alias mv='mv -v'
# Make links between files
alias link='ln -s'
# Create a directory
alias mkdir='mkdir -pv'

# Changing directories
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'

# Corlor auto
alias ls='ls --color=always -rthla'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='colordiff'

# Display the internal or external IP address
alias ipi='hostname -I | awk '\''{print $1}'\'
alias ipe='curl ipinfo.io/ip'

# APT
alias apti='apt-get install'
alias aptrm='apt-get remove'

# Network diagnostics
alias traceroute=' traceroute -T'
alias ntraceroute=' traceroute -n -T'
alias hops='mtr -T'
alias nhops='mtr -n -T'

# Vim
alias vi=vim
alias svi='vi'
alias edit='vim'

# List history of the previous commands
alias h='history'
# Cleat screen
alias c='clear'
# Display status of jobs in the current session
alias lsjobs='jobs -l'
# List tasks
alias tasks='contrab -l'

# Test internet bandwisth
alias speed='speedtest-cli'

# Display open ports
alias ports='netstat -tulanp'
alias app-ports='ss -ltup'
alias ssh-ports="ss -t state established '( dport = :ssh or sport = :ssh )'"
alias tcp-ports='ss -tlp'