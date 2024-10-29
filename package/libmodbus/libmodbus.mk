################################################################################
#
# libmodbus
#
################################################################################

LIBMODBUS_VERSION = 3.1.11
LIBMODBUS_SITE = https://github.com/stephane/libmodbus/releases/download/v$(LIBMODBUS_VERSION)
LIBMODBUS_LICENSE = LGPL-2.1+
LIBMODBUS_LICENSE_FILES = COPYING.LESSER
LIBMODBUS_CPE_ID_VENDOR = libmodbus
LIBMODBUS_INSTALL_STAGING = YES
LIBMODBUS_CONF_OPTS = --disable-tests

$(eval $(autotools-package))
