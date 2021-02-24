#!/bin/sh

case "$1" in
start)
	echo "Starting power slider daemon..."
	/usr/bin/env HOME=`sed -n 's/od:x:1000:100::\(.*\):\/usr\/bin\/sh/\1/p' /etc/passwd` \
		/sbin/start-stop-daemon -S -b -m -p /var/run/pwswd.pid \
		-c od:users -x /usr/sbin/pwswd -- -e /dev/input/by-path/platform-gpio-keys-event
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
