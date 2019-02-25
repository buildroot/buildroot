#!/bin/sh

USB_MODE=mtp

[ -r /usr/local/etc/usb.conf ] && . /usr/local/etc/usb.conf

case "$1" in
	start|stop|reload|status)
		/usr/sbin/usb $1 $USB_MODE
		;;
	*)
		echo "Usage: S15configfs.sh [start|stop|status]"
		;;
esac
