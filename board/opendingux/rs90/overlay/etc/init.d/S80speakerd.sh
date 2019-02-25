#!/bin/sh

case "$1" in

        start)
                echo "Starting speakerd..."
				/usr/sbin/start-stop-daemon -S -p /run/speakerd.pid -b -c od:users -m -x /usr/bin/speakerd
                ;;

        stop)
                echo "Stopping speakerd..."
				/usr/sbin/start-stop-daemon -K -p /run/speakerd.pid
                ;;

        *)
                echo "Usage: $0 {start|stop}"
                exit 1
esac
