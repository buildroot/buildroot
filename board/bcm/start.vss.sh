#!/bin/sh
export SOURCE=/mnt/flash/metrological
export DESTINATION=/mnt/flash/run
export CORES=/opt/cores

export LD_LIBRARY_PATH=$SOURCE/usr/lib:/lib:/usr/lib:$SOURCE/lib:$SOURCE/usr/lib/wpeframework/plugins:$SOURCE/usr/lib/wpeframework/proxystubs
export PATH=$SOURCE/usr/bin:$PATH
export GST_PLUGIN_SCANNER=$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$SOURCE/usr/lib/gstreamer-1.0

mkdir -p ${CORES}
ulimit -c unlimited
echo "${CORES}/core.%e.%p.%t" > /proc/sys/kernel/core_pattern

export GST_DEBUG=3

WPEFramework -c $SOURCE/etc/WPEFramework/config.json
