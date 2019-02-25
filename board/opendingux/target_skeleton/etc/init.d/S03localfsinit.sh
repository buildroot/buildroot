#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

mkdir -p /media/data/apps /media/data/local/home
chown od:users /media/data/apps /media/data/local/home

mount -o remount,ro /media

for i in bin etc home lib sbin share; do
	mkdir -p /usr/local/$i
	chown od:users /usr/local/$i
done

mkdir -p /var/run/sudo /var/tmp /var/log /var/lib
chmod 777 /var/tmp /var/log

[ -r /usr/local/etc/localfsinit.conf ] && . /usr/local/etc/localfsinit.conf

if [ "x$CHOWN_HOME" != "xno" ] ; then
	echo 'CHOWN_HOME=no' > /usr/local/etc/localfsinit.conf
	chown -R od:users /usr/local/home /media/data/apps 2>/dev/null
fi
