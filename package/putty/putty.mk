################################################################################
#
# putty
#
################################################################################

PUTTY_VERSION = 0.78
PUTTY_SITE = http://the.earth.li/~sgtatham/putty/$(PUTTY_VERSION)
PUTTY_LICENSE = MIT
PUTTY_LICENSE_FILES = LICENCE
PUTTY_CPE_ID_VENDOR = putty
PUTTY_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
PUTTY_DEPENDENCIES += libgtk3
else ifeq ($(BR2_PACKAGE_LIBGTK2),y)
PUTTY_DEPENDENCIES += libgtk2
endif

$(eval $(cmake-package))
