#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

psplash_write "Initializing filesystem..."

mkdir -p /media/data/apps /media/data/local/home
chown od:users /media/data/apps /media/data/local/home

mount -o remount,ro /media

for i in bin etc home lib sbin share var; do
	mkdir -p /usr/local/$i
	chown od:users /usr/local/$i
done

[ -d /usr/local/etc/network ] && chown -R od:users /usr/local/etc/network

if [ -r /sys/power/state ] ; then
	chown root:pm /sys/power/state
	chmod 664 /sys/power/state
fi

if [ -r /sys/class/rtc/rtc0/wakealarm ] ; then
	chown root:pm /sys/class/rtc/rtc0/wakealarm
	chmod 664 /sys/class/rtc/rtc0/wakealarm
fi

mkdir -p /var/run/sudo /var/tmp /var/log
chmod 777 /var/tmp /var/log

mkdir -p /usr/local/var/lib
ln -s /usr/local/var/lib /var/lib

[ -r /usr/local/etc/localfsinit.conf ] && . /usr/local/etc/localfsinit.conf

if [ "x$CHOWN_HOME" != "xno" ] ; then
	echo 'CHOWN_HOME=no' > /usr/local/etc/localfsinit.conf
	chown -R od:users /usr/local/home /media/data/apps 2>/dev/null
fi

if [ -r /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ] ; then
	cp /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq /var/tmp/boot_cpu_freq
fi
