#!/bin/sh
export SOURCE=/tmp/nfs/metrological
export DESTINATION=/tmp/nfs/cwc
export LD_LIBRARY_PATH=$SOURCE/usr/lib:/lib:/usr/lib:$SOURCE/lib
export PATH=$PATH:$SOURCE/usr/bin

export GST_PLUGIN_SCANNER=$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$SOURCE/usr/lib/gstreamer-1.0

# Currently the root system is read-only. Since we cannot add anything there we bind 
# existing directories with a copy of the actual system. All the stuff we want to 
# add is symbolicly linked in from our sources..
if [ ! -d $DESTINATION ]; then

mkdir -p $DESTINATION/share
mkdir -p $DESTINATION/etc
mkdir -p $DESTINATION/lib
cp -rfap /usr/share/* $DESTINATION/share
cp -rfap /etc/* $DESTINATION/etc
cp -rfap /usr/lib/* $DESTINATION/lib

ln -s $SOURCE/usr/share/mime $DESTINATION/share/mime
ln -s $SOURCE/usr/share/X11 $DESTINATION/share/X11
ln -s $SOURCE/usr/share/WPEFramework $DESTINATION/share/WPEFramework
ln -s $SOURCE/usr/share/fonts $DESTINATION/share/fonts
ln -s $SOURCE/etc/ssl $DESTINATION/etc/ssl
ln -s $SOURCE/etc/ssl $DESTINATION/lib/ssl
ln -s $SOURCE/etc/fonts $DESTINATION/etc/fonts
ln -s $SOURCE/etc/WPEFramework $DESTINATION/etc/WPEFramework
ln -s $SOURCE/usr/lib/gio $DESTINATION/lib/gio
ln -s /lib/libv3ddriver.so $SOURCE/usr/lib/libEGL.so 
ln -s /lib/libv3ddriver.so $SOURCE/usr/lib/libGLESv2.so 
fi

grep -q "/usr/share" /proc/mounts && echo "/usr/share is already mounted" || mount --bind $DESTINATION/share/ /usr/share/
grep -q "/etc" /proc/mounts && echo "/etc is already mounted" || mount --bind $DESTINATION/etc/ /etc/
grep -q "/usr/lib" /proc/mounts && echo "/usr/lib is already mounted" || mount --bind $DESTINATION/lib/ /usr/lib/

cp -rfap $SOURCE/etc/playready/* /etc/playready/
ln -s $SOURCE/etc/ssl /etc/ssl

if [ ! -d $SOURCE/persistent/Netflix ]; then 
	mkdir -p $SOURCE/persistent/Netflix/dpi
	ln -sfn /etc/playready $SOURCE/persistent/Netflix/dpi/playready
fi

# Firewall for non-prod builds
iptables -I INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

LD_PRELOAD=$SOURCE/lib/libstdc\+\+.so.6.0.21:/lib/libnexus.so WPEFramework -c $SOURCE/etc/WPEFramework/config.json

