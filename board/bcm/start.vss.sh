#!/bin/bash
export LD_LIBRARY_PATH='/lib:/usr/lib:/mnt/flash/wpe/usr/lib'
export GST_PLUGIN_SYSTEM_PATH=/usr/lib/gstreamer-1.0-wpe
export GST_REGISTRY=/tmp/gst-registry.bin
WPEFramework1 "$@"
