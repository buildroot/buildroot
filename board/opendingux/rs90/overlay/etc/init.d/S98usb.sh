#!/bin/sh

USB_MODE=mtp

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
		echo "Usage: S15configfs.sh [start|stop|status]"
		;;
esac
