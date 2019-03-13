# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

unset PROMPT_COMMAND
PROMPT_COMMAND='echo -ne "\033]0;`hostname`\007"'
export PROMPT_COMMAND

export SVN_EDITOR=vim
export P4CONFIG=~/.perforce

alias l.='ls -dG .*'
alias ll='ls -lG'
alias ls='ls -G --color=auto'


## Define some colors for easy use ##
## Bold colors in caps ##

function black {
local cblack="\[\033[0;30m\]"
PS1="$cblack\u@\h.$DC [\t] \W > "
}

function BLACK {
local color="\[\033[1;30m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function red {
local color="\[\033[0;31m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function RED {
local color="\[\033[1;31m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function green {
local color="\[\033[0;32m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function GREEN {
local color="\[\033[1;32m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function yellow {
local color="\[\033[0;33m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function YELLOW {
local color="\[\033[1;33m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function blue {
local color="\[\033[0;34m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function BLUE {
local color="\[\033[1;34m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function purple {
local color="\[\033[0;35m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function PURPLE {
local color="\[\033[1;35m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function cyan {
local color="\[\033[0;36m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function CYAN {
local color="\[\033[1;36m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function WHITE {
local color="\[\033[1;37m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function white {
local color="\[\033[0;37m\]"
PS1="$color\u@\h.$DC [\t] \W > "
}

function NC {
local color="\[\033[0m\]"
PS1="$color\u@\h.$DC [\t] \W > "
} # no color

function prompt {
local BLUE="\[\033[0;34m\]"
local DARK_BLUE="\[\033[1;34m\]"
local RED="\[\033[0;31m\]"
local DARK_RED="\[\033[1;31m\]"
local NO_COLOR="\[\033[0m\]"
PS1="$BLUE\u@\h.$DC $RED[\t] \W >$NO_COLOR "
}
prompt

# TO RUN USE "dump1 -nn -c100 $flags"
flags='tcp[13]=0 || tcp[13]=3 || tcp[13]=5 || tcp[13]=6 || tcp[13]=7 || tcp[13]=9 || tcp[13]=10 || tcp[13]=11 || tcp[13]=15 || tcp[13]=23 || tcp[13]=26 || tcp[13]=28 || tcp[13]=31 || tcp[13]=33 || tcp[13]=37 || tcp[13]=41 || tcp[13]=45 || tcp[13]=63 || tcp[13]=192 || tcp[13]=255'

function getgrep {
egrep $1 $2 'GET /|POST /|HEAD /|OPTION /|PUT /'
}
alias tmcp="tmux show-buffer | pbcopy"

torhash(){
  EXPECTED_ARGS=1
  E_BADARGS=65

  if [ $# -lt $EXPECTED_ARGS ]
  then
  echo "need password for tor control."
  return $E_BADARGS
  fi

  echo "export TORHASH=`tor --hash-password $1`"
}

torup(){

  EXPECTED_ARGS=1
  E_BADARGS=65

  if [ $# -lt $EXPECTED_ARGS ]
  then
    echo "need to add a country code."
    return $E_BADARGS
  fi

  if [ -z $TORHASH ]
  then
    pass=`random_alpha_num 8`
    echo "TORHASH is not set setting tor ControlPassword to $pass"
    TORHASH = `tor --hash-password $pass`
  fi

  cc=$1
  sudo tor --user jrespeto --DNSPort 29050 --allow-missing-torrc --ignore-missing-torrc --Log "notice file /opt/local/var/log/tor/notices.log" --Log "debug file /opt/local/var/log/tor/debug.log" --RunAsDaemon 1 --DataDirectory $HOME/.tor --SocksPort 9050 --ControlPort 19050 --HashedControlPassword $TORHASH --ExitNodes "{$cc}" --StrictNodes 1
}

#OSX allow wireshare access to interfaces.
fixbpf(){
sudo chgrp admin /dev/bpf*
sudo chmod g+rw /dev/bpf*
}

kaliup(){
  sudo apt update
  sudo apt full-upgrade
}

ipinfo(){
echo "-f $1"|nc whois.cymru.com 43
whois -ah whois.pwhois.org "routeview prefix=$1"
}

random_alpha(){
cat /dev/urandom | LC_CTYPE=C tr -dc "[:alpha:]" | head -c $1
}

random_alpha_num(){
cat /dev/urandom | LC_CTYPE=C tr -dc "[:alnum:]" | head -c $1
}

random_num(){
cat /dev/urandom | LC_CTYPE=C tr -dc "[:digit:]" | head -c $1;
}

torcurl() {
	EXPECTED_ARGS=2
	E_BADARGS=65

	if [ $# -lt $EXPECTED_ARGS ]
		then
		echo "need  domain and tor port."
		return $E_BADARGS
	fi
    domain=$1
    port=$2
    proto=$3
    if [ -z $proto ]
       then
       proto='http'
    fi
    START=$(date +%s)
    ip=`dig @localhost -p 2$port $domain +short`
    curl -qLSs -k -4 --socks5 localhost:$port -o /dev/null -v --tcp-fastopen --tcp-nodelay -H"Host: $domain" "$proto://$ip"
    END=$(date +%s)
    DIFF=$(( $END - $START ))
    echo "It took $DIFF seconds"
}

mk_proxychain_conf() {
	EXPECTED_ARGS=2
	E_BADARGS=65

	if [ $# -lt $EXPECTED_ARGS ]
	then
		echo "need  filename and (tor port or tor port range)."
		return $E_BADARGS
	fi
	filename=$1
	start=$2
	end=$3

echo "random_chain
chain_len = 1
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 3000
tcp_connect_time_out 1000
[ProxyList]" > $filename

if [ -z end ]
then
	for i in $start
	do echo "socks5 127.0.0.1 $i" >> $filename
	done
else
	for port in `seq $start $end`
	do echo "socks5 127.0.0.1 $port" >> $filename
	done
fi
}

torup_range(){
EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -lt $EXPECTED_ARGS ]
then
echo "need tor port range)."
return $E_BADARGS
fi

if [ -z $TORHASH ]
then
  pass=`random_alpha_num 8`
  echo "TORHASH is not set setting tor ControlPassword to $pass"
  TORHASH = `tor --hash-password $pass`
fi

start=$1
end=$2

for i in `seq $start $end`;
	do tor --DNSPort 2$i --allow-missing-torrc --ignore-missing-torrc --Log "notice file /opt/local/var/log/tor/notices.log" --Log "debug file /opt/local/var/log/tor/debug.log" --RunAsDaemon 1 --DataDirectory $HOME/.tor-$i --SocksPort $i --ControlPort 1$i --HashedControlPassword $TORHASH ;
	done

}
