#!/bin/sh

# We run dropbear from inetd
rm -f $1/etc/init.d/S50dropbear

# No need for udev's HW database
rm -rf $1/etc/udev/hwdb.d

# We only support 240x160
rm -rf $1/usr/share/gmenu2x/skins/{320x240,800x480}

if [ ! -h $1/usr/share/fonts/truetype ] ; then
	ln -s . $1/usr/share/fonts/truetype
fi

exit 0
