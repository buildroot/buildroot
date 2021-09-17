#!/bin/sh

case "$1" in

	start)
		psplash_write "Starting watchdog..."

		# Defaults.
		. /etc/watchdog.conf

		# User overrides.
		if [ -f /usr/local/etc/watchdog.conf ]; then
			. /usr/local/etc/watchdog.conf
		fi

		/usr/sbin/start-stop-daemon -S -b -p /run/watchdog.pid -m -x /usr/sbin/watchdog \
			-- -F -T $WATCHDOG_TIMEOUT -t $WATCHDOG_KICK_RATE /dev/watchdog
		;;

	stop)
		psplash_write "Stopping watchdog..."

		/usr/sbin/start-stop-daemon -K -p /run/watchdog.pid
		;;

	restart)
		$0 stop
		$0 start
		;;

	status)
		/usr/sbin/start-stop-daemon -T -p /run/watchdog.pid
		;;
esac

