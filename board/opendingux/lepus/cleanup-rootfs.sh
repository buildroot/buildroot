#!/bin/sh

# We run dropbear from inetd
rm -f $1/etc/init.d/S50dropbear

# No need for udev's HW database
rm -rf $1/etc/udev/hwdb.d
