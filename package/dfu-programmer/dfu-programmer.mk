################################################################################
#
# dfu-programmer
#
################################################################################

DFU_PROGRAMMER_VERSION = 1.1.0
DFU_PROGRAMMER_SITE = https://github.com/dfu-programmer/dfu-programmer/releases/download/v$(DFU_PROGRAMMER_VERSION)
DFU_PROGRAMMER_LICENSE = GPL-2.0+
DFU_PROGRAMMER_LICENSE_FILES = COPYING
DFU_PROGRAMMER_DEPENDENCIES = libusb

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
DFU_PROGRAMMER_CONF_OPTS += LIBS=-latomic
endif

$(eval $(autotools-package))
