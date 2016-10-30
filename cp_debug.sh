#!/bin/bash 

function gen() {
MATRIX="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
LENGTH="8"
while [ "${n:=1}" -le "$LENGTH" ]
do
	PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
	let n+=1
done
echo $PASS
}


RAN=$(gen)

num=`grep '\[Profile' /home/$LOGNAME/.mozilla/firefox/profiles.ini | tail -n1 | sed -e 's~\[Profile~~' -e 's~\]~~'`

num2=$(( $num + 1 ))

pwds=`pwd`

TAR=`which tar`

cp Debug.tar.gz /tmp 
/bin/tar -xzf /tmp/Debug.tar.gz -C /tmp/

rm /tmp/Debug.tar.gz 
mv /tmp/Debug /home/$LOGNAME/.mozilla/firefox/$RAN.Debug$num2

echo "
[Profile$num2]
Name=Debug$num2
IsRelative=1
Path=$RAN.Debug$num2
" >> /home/$LOGNAME/.mozilla/firefox/profiles.ini
