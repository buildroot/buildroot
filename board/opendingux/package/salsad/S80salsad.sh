#!/bin/sh

case "$1" in

        start)
                echo "Starting salsad..."
				/usr/sbin/start-stop-daemon -S -p /run/salsad.pid -b -c od:users -m -x /usr/bin/salsad -- hw:0
                ;;

        stop)
                echo "Stopping salsad..."
				/usr/sbin/start-stop-daemon -K -p /run/salsad.pid
                ;;

        *)
                echo "Usage: $0 {start|stop}"
                exit 1
esac
