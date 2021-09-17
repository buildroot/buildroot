#!/bin/sh
#
# Simple script to load/store ALSA parameters (volume...)
#

VOLUME_STATEFILE=/usr/local/etc/volume.state
CONTROL=PCM

case "$1" in
	start)
		psplash_write "Loading sound volume..."
		if [ -f $VOLUME_STATEFILE ]; then
			/usr/bin/amixer set $CONTROL `cat $VOLUME_STATEFILE`
		fi
		;;
	stop)
		psplash_write "Storing sound volume..."
		amixer get $CONTROL | sed -n 's/.*Front .*: Playback \([0-9]*\).*$/\1/p' | paste -d "," - - > $VOLUME_STATEFILE
		;;
	*)
		echo "Usage: $0 {start|stop}"
		exit 1
esac

exit $?
