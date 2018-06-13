#!/bin/sh
export SOURCE=/metro
export LD_LIBRARY_PATH=$SOURCE/usr/lib:$SOURCE/usr/lib/wpeframework:$SOURCE/usr/lib/wpeframework/plugins:$SOURCE/usr/lib/wpeframework/proxystubs:/lib:/usr/lib:$SOURCE/lib
export PATH=$PATH:$SOURCE/usr/bin

export GST_PLUGIN_SCANNER=$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$SOURCE/usr/lib/gstreamer-1.0

LD_PRELOAD=$SOURCE/usr/lib/libstdc\+\+.so.6.0.21 WPEFramework
