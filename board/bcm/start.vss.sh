#!/bin/sh
export SOURCE=/home/metrological
export CORES=/opt/cores

grep -q "/usr/lib/gio" /proc/mounts &&
                echo "/usr/lib/gio is already mounted" || mount --bind $SOURCE/usr/lib/gio /usr/lib/gio

export LD_LIBRARY_PATH=$SOURCE/usr/ml_libs:/lib:/usr/lib:$SOURCE/lib:$SOURCE/usr/lib:$SOURCE/usr/lib/wpeframework/plugins:$SOURCE/usr/lib/wpeframework/proxystubs
export PATH=$SOURCE/usr/bin:$PATH

export GST_PLUGIN_SCANNER=$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$SOURCE/usr/ml_libs/gstreamer-1.0
export GST_REGISTRY=/tmp/gst-registry.bin

mkdir -p ${CORES}
ulimit -c unlimited
echo "${CORES}/core.%e.%p.%t" > /proc/sys/kernel/core_pattern

WPEFramework -c $SOURCE/etc/WPEFramework/config.json
