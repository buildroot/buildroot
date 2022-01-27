################################################################################
#
# xr819-xradio
#
################################################################################

XR819_XRADIO_VERSION = 16180b6308e3c5dc42a92a663adf669028087ff7
XR819_XRADIO_SITE = $(call github,fifteenhex,xradio,$(XR819_XRADIO_VERSION))
XR819_XRADIO_LICENSE = GPL-2.0
XR819_XRADIO_LICENSE_FILES = LICENSE

$(eval $(kernel-module))
$(eval $(generic-package))
