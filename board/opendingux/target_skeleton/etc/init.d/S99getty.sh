#!/bin/sh

TTYS="ttyS0 ttyS1 ttyS2 ttyS3 ttyS4"

spawn_getty() {
	IFS= read -r -d $'\0' MODEL </sys/firmware/devicetree/base/compatible

	case "$MODEL" in
		img,ci20)
			TTY_SPEED=115200
			;;
		*)
			TTY_SPEED=57600
			;;
	esac

	for tty in ${TTYS} ; do
		if [ -c /dev/${tty} ] ; then
			/usr/sbin/start-stop-daemon -S -b \
				-p /run/${tty}.pid -m -x /usr/bin/respawn \
				-- /usr/sbin/getty -n -l /usr/sbin/odlogin \
				-L ${tty} ${TTY_SPEED} vt100
		fi
	done
}

stop_getty() {
	for tty in ${TTYS} ; do
		if [ -c /dev/${tty} ] ; then
			/usr/sbin/start-stop-daemon -K -p /run/${tty}.pid
		fi
	done
}

case "$1" in
	start)
		psplash_write "Spawning getty..."
		spawn_getty
		;;

	stop)
		psplash_write "Stopping getty..."
		stop_getty
		;;
esac
