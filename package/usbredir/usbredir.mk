################################################################################
#
# usbredir
#
################################################################################

USBREDIR_VERSION = 0.14.0
USBREDIR_SOURCE = usbredir-$(USBREDIR_VERSION).tar.xz
USBREDIR_SITE = https://www.spice-space.org/download/usbredir
USBREDIR_LICENSE = LGPL-2.1+ (libraries)
USBREDIR_LICENSE_FILES = COPYING.LIB
USBREDIR_INSTALL_STAGING = YES
USBREDIR_DEPENDENCIES = host-pkgconf libusb
USBREDIR_CONF_OPTS = \
	-Dgit_werror=disabled \
	-Dstack_protector=disabled \
	-Dtests=disabled

ifeq ($(BR2_PACKAGE_USBREDIR_TOOLS),y)
USBREDIR_LICENSE += , GPL-2.0+ (program)
USBREDIR_LICENSE_FILES += COPYING
USBREDIR_DEPENDENCIES += libglib2
USBREDIR_CONF_OPTS += -Dtools=enabled
else
USBREDIR_CONF_OPTS += -Dtools=disabled
endif

$(eval $(meson-package))
