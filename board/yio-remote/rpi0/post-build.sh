#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

ln -fs ../../../../usr/lib/systemd/system/wpa_supplicant@.service $1/etc/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service

ln -fs ../../../../usr/lib/systemd/system/backlight.service $1/etc/systemd/system/multi-user.target.wants/backlight.service

ln -fs ../../../../usr/lib/systemd/system/sharp-init.service $1/etc/systemd/system/multi-user.target.wants/sharp-init.service

ln -fs ../../../../usr/lib/systemd/system/app.service $1/etc/systemd/system/sysinit.target.wants/app.service

ln -fs ../../../../usr/lib/systemd/system/shutdown.service $1/etc/systemd/system/halt.target.wants/shutdown.service

ln -fs ../../../../usr/lib/systemd/system/shutdown.service $1/etc/systemd/system/poweroff.target.wants/shutdown.service


rm -rf $1/var/log/journal

#rm -r $1/etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service.

#rm -r $1/etc/systemd/system/dbus-org.freedesktop.timesync1.service

