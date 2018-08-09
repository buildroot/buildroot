#!/bin/sh
export SOURCE=/tmp/nfs/metrological
export LD_LIBRARY_PATH=$SOURCE/usr/lib:$SOURCE/lib:/lib/:usr/lib
export PATH=$PATH:$SOURCE/usr/bin

export GST_PLUGIN_SCANNER=$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$SOURCE/usr/lib/gstreamer-1.0

# Added missing paths
export FONTCONFIG_PATH=/tmp/nfs/metrological/etc/fonts/
export XKB_CONFIG_ROOT=/tmp/nfs/metrological/usr/share/X11/xkb/
export GIO_MODULE_DIR=$SOURCE/usr/lib/gio/modules

# GnuTLS doesn’t honor an environment variable like ‘SSL_CERT_DIR’.
# As temporary solution bind directory with ca-certificates.
export DESTINATION=/tmp/nfs/cwc
if [ ! -d $DESTINATION ]; then
mkdir -p $DESTINATION//etc/ssl/certs
    cp -rfap /etc/* $DESTINATION//etc/ssl/certs
    ln -s $SOURCE/etc/ssl/certs/ca-certificates.crt $DESTINATION/etc/ssl/certs/ca-certificates.crt
fi

grep -q "/etc/ssl/certs" /proc/mounts && echo "/etc/ssl/certs is already mounted" || mount --bind $DESTINATION/etc/ssl/certs /etc/ssl/certs

# Firewall for non-prod builds
iptables -I INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
LD_PRELOAD=$SOURCE/lib/libstdc\+\+.so.6.0.21:/lib/libnexus.so WPEFramework -c $SOURCE/etc/WPEFramework/config.json 2>&1 | logger -t “WPEFramework”
