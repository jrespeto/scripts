# Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

# User specific environment and startup programs

export PATH
HISTSIZE=1000
HISTFILESIZE=1000
HISTFILE=~/.bash_history
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups
export HISTCONTROL=ignorespace

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/libexec:$PATH"
