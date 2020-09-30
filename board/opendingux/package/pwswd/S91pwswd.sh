#!/bin/sh

for event in `ls -d /sys/class/input/event*` ; do
	NAME=`basename "$event"`
	KEY=`cat "$event/device/capabilities/key"`
	if [ "$KEY" != "0" ] ; then
		EVENT="$NAME"
		break
	fi
done


case "$1" in
start)
	echo "Starting power slider daemon..."
	/usr/bin/env HOME=`cat /etc/passwd |head -1 |cut -d':' -f 6`	\
		/sbin/start-stop-daemon -S -b -m -p /var/run/pwswd.pid \
		-x /usr/sbin/pwswd -- -e /dev/input/$EVENT
	;;
stop)
	echo "Stopping power slider daemon..."
	start-stop-daemon -K -q -p /var/run/pwswd.pid
	rm -f /var/run/pwswd.pid
	;;
status)
	RET=1
	if [ -r /var/run/pwswd.pid ] ; then
		kill -0 `cat /var/run/pwswd.pid` 2>&1 >/dev/null
		RET=$?
	fi
	if [ $RET -eq 0 ] ; then
		echo "pwswd is running"
	else
		echo "pwswd is NOT running"
	fi
	exit $RET
	;;
*)
	echo "Usage: $0 {start|stop|status}"
	exit 1
esac

exit $?
