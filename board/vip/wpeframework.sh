#!/bin/sh
export SOURCE=/hdd/metrological
export ACN=/hdd/acn
export LD_LIBRARY_PATH=$SOURCE/usr/lib:/lib:/usr/lib:$SOURCE/lib
export PATH=$PATH:$SOURCE/usr/bin


# Currently the root system is read-only. Since we cannot add anything there we bind 
# existing directories with a copy of the actual system. All the stuff we want to 
# add is symbolicly linked in from our sources..
if [ ! -d $ACN ]; then

mkdir -p $ACN/share
mkdir -p $ACN/etc
mkdir -p $ACN/lib
cp -rfap /usr/share/* $ACN/share
cp -rfap /etc/* $ACN/etc
cp -rfap /usr/lib/* $ACN/lib

ln -s $SOURCE/usr/share/mime $ACN/share/mime
ln -s $SOURCE/usr/share/X11 $ACN/share/X11
ln -s $SOURCE/usr/share/WPEFramework $ACN/share/WPEFramework
ln -s $SOURCE/usr/share/fonts $ACN/share/fonts
ln -s $SOURCE/etc/ssl $ACN/etc/ssl
ln -s $SOURCE/etc/ssl $ACN/lib/ssl
ln -s $SOURCE/etc/fonts $ACN/etc/fonts
ln -s $SOURCE/etc/WPEFramework $ACN/etc/WPEFramework
ln -s $SOURCE/usr/lib/gio $ACN/lib/gio
fi

mount -t ext4 --bind $ACN/share/ /usr/share/
mount -t ext4 --bind $ACN/etc/ /etc/
mount -t ext4 --bind $ACN/lib/ /usr/lib/

LD_PRELOAD=$SOURCE/lib/libstdc\+\+.so.6.0.20 WPEFramework
