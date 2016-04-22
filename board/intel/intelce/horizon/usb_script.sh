#!/bin/sh
set -x 
SOURCE=/mnt/usb
cp $SOURCE/usr/lib/libstdc++.so.6.0.20 /lib/libstdc++.so.6.0.14
cp $SOURCE/NDS/webbridge-stub /NDS/bin/webbridge
#ln -sfn $SOURCE/NDS/webbridge /NDS/bin/webbridge
ln -sfn $SOURCE/etc/playready /etc/playready
ln -sfn $SOURCE/etc/ssl /etc/ssl
ln -sfn $SOURCE/etc/fonts /etc/fonts
ln -sfn $SOURCE/usr/lib/gio /usr/lib/gio
ln -sfn $SOURCE/usr/lib/libgenerics.so.1.0 /NDS/lib/libgenerics.so.1.0
ln -sfn $SOURCE/usr/lib/libmqc.so.1.0 /NDS/lib/libmqc.so.1.0
ln -sfn $SOURCE/usr/lib/libtracing.so.1.0 /NDS/lib/libtracing.so.1.0
mkdir -p /usr/share/fonts
ln -sfn $SOURCE/usr/share/mime /usr/share/mime
ln -sfn $SOURCE/usr/share/X11 /usr/share/X11
ln -sfn $SOURCE/usr/share/fonts/ttf-bitstream-vera /usr/share/fonts/ttf-bitstream-vera

if [ -b /dev/sdb2 ]
then
	swapon /dev/sdb2
fi
