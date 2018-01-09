#!/bin/bash

set -u
set -e

echo "Post-build: processing $@"

for i in "$@"
do
case "$i" in
	--rpi-wifi)
	if ! grep -qE '^auto wlan0' "${TARGET_DIR}/etc/network/interfaces"; then
		echo "Adding 'wlan0 network' functionality to /etc/network/interfaces."
		cat << __EOF__ >> "${TARGET_DIR}/etc/network/interfaces"

auto wlan0
iface wlan0 inet dhcp
    pre-up wpa_supplicant -Dwext -iwlan0 -c/etc/wpa_supplicant.conf -B
    down killall wpa_supplicant
__EOF__
		cat << __EOF__ > "${TARGET_DIR}/etc/wpa_supplicant.conf"
ctrl_interface=/var/run/wpa_supplicant
ap_scan=1

__EOF__
	fi
	;;
	--rpi-wifi-ap)
	if ! grep -qE '^auto wlan0' "${TARGET_DIR}/etc/network/interfaces"; then
		echo "Adding 'wlan0 network' functionality to /etc/network/interfaces as Access Point."
		cat << __EOF__ >> "${TARGET_DIR}/etc/network/interfaces"

auto wlan0
iface wlan0 inet static
    pre-up wpa_supplicant -Dnl80211 -iwlan0 -c/etc/wpa_supplicant.conf -B
    down killall wpa_supplicant
    address 192.168.20.1
    netmask 255.255.255.0
__EOF__
		cat << __EOF__ > "${TARGET_DIR}/etc/wpa_supplicant.conf"
ctrl_interface=/var/run/wpa_supplicant
ap_scan=1
ctrl_interface_group=0
fast_reauth=1
update_config=1

network={
    ssid="WiFiRasp"
    mode=2
    frequency=2412
    key_mgmt=WPA-PSK
    proto=RSN
    pairwise=CCMP
    psk="12345678"
}
__EOF__
	fi
	;;
esac

done

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

BOARD_DIR="$(dirname $0)"

# Add Gstreamer software based AC3 Decoder
if [ -f "${BOARD_DIR}/libgstfluac3dec.so" ]; then
	mkdir -p "${TARGET_DIR}/usr/lib/gstreamer-1.0/"
	cp -pf "${BOARD_DIR}/libgstfluac3dec.so" "${TARGET_DIR}/usr/lib/gstreamer-1.0/"
fi

# Copy index.html page for WPE Framework
if [ -f "${BOARD_DIR}/index.html" ]; then
	mkdir -p "${TARGET_DIR}/www/"
	cp -pf "${BOARD_DIR}/index.html" "${TARGET_DIR}/www/"
fi
