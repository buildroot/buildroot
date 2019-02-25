#!/bin/sh
#
# Simple script to load/store ALSA parameters (volume...)
#

VOLUME_STATEFILE=/usr/local/etc/volume.state
CONTROL=PCM

case "$1" in
	start)
		echo "Loading sound volume..."
		if [ -f $VOLUME_STATEFILE ]; then
			/usr/bin/amixer set $CONTROL `cat $VOLUME_STATEFILE`
		fi
		;;
	stop)
		echo "Storing sound volume..."
		echo `/usr/bin/alsa-getvolume default $CONTROL` > $VOLUME_STATEFILE
		;;
	*)
		echo "Usage: $0 {start|stop}"
		exit 1
esac

exit $?
