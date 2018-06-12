#!/bin/sh
export SOURCE=/mnt/flash/metrological
export CORES=/opt/cores
# export GST_DEBUG=3

export LD_LIBRARY_PATH=$SOURCE/usr/lib:/lib:/usr/lib:$SOURCE/lib:$SOURCE/usr/lib/wpeframework/plugins:$SOURCE/usr/lib/wpeframework/proxystubs
export PATH=$SOURCE/usr/bin:$PATH
export GST_PLUGIN_SCANNER=$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$SOURCE/usr/lib/gstreamer-1.0
export GST_REGISTRY=$SOURCE/gst-registry.bin

export XKB_CONFIG_ROOT=$SOURCE/usr/share/X11/xkb

mkdir -p ${CORES}
ulimit -c unlimited
echo "${CORES}/core.%e.%p.%t" > /proc/sys/kernel/core_pattern

WPEFramework -c $SOURCE/etc/WPEFramework/config.json
