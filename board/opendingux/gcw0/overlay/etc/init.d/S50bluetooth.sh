#!/bin/sh
#
# Start bluetooth daemon
#

case "$1" in
	start)
		if [ -x /usr/libexec/bluetooth/bluetoothd ] ; then
			psplash_write "Starting Bluetooth... "
			/usr/sbin/start-stop-daemon -S -b -m -p /var/run/bluetoothd.pid -x /usr/libexec/bluetooth/bluetoothd
		fi
		;;
	stop)
		if [ -x /usr/libexec/bluetooth/bluetoothd ] ; then
			psplash_write "Stopping Bluetooth..."
			/usr/sbin/start-stop-daemon -K -p /var/run/bluetoothd.pid
		fi
		;;
	*)
		echo "Usage: $0 {start|stop}"
		exit 1
esac

exit $?
