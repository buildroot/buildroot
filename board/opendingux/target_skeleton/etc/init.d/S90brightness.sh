#!/bin/sh
#
# Simple script to load/store screen brightness
#

. /etc/brightness.conf

STATEFILE=/usr/local/etc/brightness.state

case "$1" in
	start)
		psplash_write "Loading brightness setting..."

		if [ -r $STATEFILE ]; then
			cat $STATEFILE > $SYSFSFILE
		fi
		;;
	stop)
		psplash_write "Storing brightness setting..."

		cp $SYSFSFILE $STATEFILE
		;;
	*)
		echo "Usage: $0 {start|stop}"
		exit 1
esac

exit $?
