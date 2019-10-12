#!/bin/sh

# try thhis -inet 192.168.64.205/23 brd 192.168.65.255 scope global noprefixroute enp2s0

IP="$1"

GATEWAY="$2"

INTERFACE="$3"

if [ $1 ];
then 
	IP="$1"
else 
  	IP="192.168.64.224/24"
fi

if [ $2 ];
then 
	GATEWAY="$2"
else 
  	GATEWAY="192.168.64.254"
fi

if [ $3 ];
then 
	INTERFACE="$3"
else 
  	INTERFACE="enp2s0"
fi

echo "Argument 1: IP(CIDR), Argument 2: GATEWAY, Argument 3: INTERFACE" 

sudo ip link set dev $INTERFACE down
sudo ip link set dev $INTERFACE up
sudo ip a flush dev $INTERFACE
sudo ip route flush dev $INTERFACE 
sudo ip a add $IP dev $INTERFACE
sudo ip route add default via $GATEWAY dev $INTERFACE 

echo "Script Completed\n"
