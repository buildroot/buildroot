################################################################################
#
# putty
#
################################################################################

PUTTY_VERSION = 0.80
PUTTY_SITE = http://the.earth.li/~sgtatham/putty/$(PUTTY_VERSION)
PUTTY_LICENSE = MIT
PUTTY_LICENSE_FILES = LICENCE
PUTTY_CPE_ID_VENDOR = putty
PUTTY_DEPENDENCIES = host-pkgconf
PUTTY_CONF_OPTS = -DPUTTY_GSSAPI=OFF

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
PUTTY_DEPENDENCIES += libgtk3
else ifeq ($(BR2_PACKAGE_LIBGTK2),y)
PUTTY_DEPENDENCIES += libgtk2
endif

ifeq ($(BR2_STATIC_LIBS),y)
PUTTY_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -DNO_LIBDL"
endif

$(eval $(cmake-package))
