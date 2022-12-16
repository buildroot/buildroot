#!/bin/sh

USB_MODE=mtp

IFS= read -r -d $'\0' MODEL </sys/firmware/devicetree/base/compatible

case "$MODEL" in
	# Only the RS90 needs to start USB at bootup, because it does not have
	# USB cable detection.
	ylm,rs90)
		;;
	*)
		return 0
		;;
esac

[ -r /usr/local/etc/usb.conf ] && . /usr/local/etc/usb.conf

case "$1" in
	start)
		psplash_write "Starting USB..."
		/usr/sbin/usb $1 $USB_MODE
		;;

	stop)
		psplash_write "Stopping USB..."
		/usr/sbin/usb $1 $USB_MODE
		;;

	reload|status)
		/usr/sbin/usb $1 $USB_MODE
		;;
	*)
		echo "Usage: S98usb.sh [start|stop|status]"
		;;
esac
