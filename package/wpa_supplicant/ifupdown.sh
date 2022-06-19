#!/bin/sh

# This file is executed by ifupdown in pre-up, post-up, pre-down and
# post-down phases of network interface configuration.

WPA_SUP_BIN="/usr/sbin/wpa_supplicant"

# run this script only for interfaces which have wpa-conf option
[ -z "$IF_WPA_CONF" ] && exit 0

# Allow wpa_supplicant interface to be specified via wpa-iface
# useful for starting wpa_supplicant on one interface of a bridge
if [ -n "$IF_WPA_IFACE" ]; then
	WPA_IFACE="$IF_WPA_IFACE"
else
	WPA_IFACE="$IFACE"
fi

WPA_SUP_PIDFILE="/run/wpa_supplicant.${WPA_IFACE}.pid"

do_start () {
	if [ ! -s "$IF_WPA_CONF" ]; then
		echo "cannot read contents of $IF_WPA_CONF"
		exit 1
	fi
	WPA_SUP_CONF="-c $IF_WPA_CONF"
}

case "$MODE" in
	start)
		do_start
		case "$PHASE" in
			post-up)
				start-stop-daemon -S -q -x ${WPA_SUP_BIN} \
				-- -B -i ${WPA_IFACE} ${WPA_SUP_CONF} -P ${WPA_SUP_PIDFILE}
				;;
		esac
		;;

	stop)
		case "$PHASE" in
			pre-down)
				start-stop-daemon -K -p ${WPA_SUP_PIDFILE}
				;;
		esac
		;;
esac

exit 0
