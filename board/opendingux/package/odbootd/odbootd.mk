################################################################################
#
# odbootd
#
################################################################################

ODBOOTD_VERSION = fc4f329
ODBOOTD_SITE = $(call github,opendingux,odbootd,$(ODBOOTD_VERSION))

HOST_ODBOOTD_DEPENDENCIES = host-libusb

ODBOOTD_CONF_OPTS = -DWITH_ODBOOT_CLIENT:BOOL=OFF
HOST_ODBOOTD_CONF_OPTS = -DWITH_ODBOOTD:BOOL=OFF

$(eval $(cmake-package))
$(eval $(host-cmake-package))
