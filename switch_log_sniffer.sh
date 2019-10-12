#!/bin/sh

HOST="$(/sbin/ip route | awk "/default/ { print $3 }")"

USER="$1@$HOST"

if [ $1 ];
then 
	USER="$1"
else 
  	USER="admin"
fi

if [ $2 ];
then 
	HOST="$2"
else 
  	HOST="$(/sbin/ip route | awk '/default/ { print $3 }')"
fi

echo "specify custom username for ssh login in 1st commandline-argument \nor by default 'admin' will be used for cisco routers\n"
echo "specify custom switch ip address for ssh login in 2nd commandline-argument \nor by default system's default gateway will be used\n"
echo "default password is 'cisco'\n"

script switch.log -c "

(
	sleep 2

	echo 'terminal length 0'

	sleep 2

	echo 'show log'

) | ssh -l $USER $HOST"

exit
