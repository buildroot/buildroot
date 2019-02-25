#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

if [ ! -f /usr/local/etc/shadow ]; then
	echo 'od:*:::::::' > /usr/local/etc/shadow
	chmod 600 /usr/local/etc/shadow
fi
