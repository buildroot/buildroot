#!/bin/sh
set -x

switch=br0

if [ -n "$1" ];then
        ip tuntap add $1 mode tap user `whoami`		#create tap network interface
        ip link set $1 up				#bring interface tap up
        sleep 0.5s					#wait the interface come up.
        sysctl -w net.ipv4.ip_forward=1                 # allow forwarding of IPv4
	route add -host 192.168.1.10 dev $1 		# add route to the client
        exit 0
else
        echo "Error: no interface specified"
        exit 1
fi