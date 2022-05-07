################################################################################
#
# xr819-xradio
#
################################################################################

XR819_XRADIO_VERSION = 4f0cfd5e869ca101e7c624d9ce05ba5d2b2a0bc2
XR819_XRADIO_SITE = $(call github,fifteenhex,xradio,$(XR819_XRADIO_VERSION))
XR819_XRADIO_LICENSE = GPL-2.0
XR819_XRADIO_LICENSE_FILES = LICENSE

$(eval $(kernel-module))
$(eval $(generic-package))
