################################################################################
#
# libamazon
#
################################################################################

LIBAMAZON_VERSION = 66a868203c713fd6d16b6373e628e88f12a5e840
LIBAMAZON_SITE_METHOD = git
LIBAMAZON_SITE = git@github.com:Metrological/libamazon.git
LIBAMAZON_LICENSE = PROPRIETARY
LIBAMAZON_REDISTRIBUTE = NO
LIBAMAZON_INSTALL_STAGING = YES

LIBAMAZON_DEPENDENCIES = zlib jpeg libcurl libpng wpeframework gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad

$(eval $(cmake-package))
