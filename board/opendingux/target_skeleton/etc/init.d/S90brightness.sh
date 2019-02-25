#!/bin/sh
#
# Simple script to load/store screen brightness
#

. /etc/brightness.conf

STATEFILE=/usr/local/etc/brightness.state

case "$1" in
	start)
		echo "Loading brightness setting..."
		if [ -r $STATEFILE ]; then
			cat $STATEFILE > $SYSFSFILE
		fi
		;;
	stop)
		echo "Storing brightness setting..."
		cp $SYSFSFILE $STATEFILE
		;;
	*)
		echo "Usage: $0 {start|stop}"
		exit 1
esac

exit $?
