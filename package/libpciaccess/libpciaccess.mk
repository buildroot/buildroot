################################################################################
#
# libpciaccess
#
################################################################################

LIBPCIACCESS_VERSION = 0.18.1
LIBPCIACCESS_SOURCE = libpciaccess-$(LIBPCIACCESS_VERSION).tar.xz
LIBPCIACCESS_SITE = http://xorg.freedesktop.org/releases/individual/lib
LIBPCIACCESS_LICENSE = MIT
LIBPCIACCESS_LICENSE_FILES = COPYING
LIBPCIACCESS_INSTALL_STAGING = YES
LIBPCIACCESS_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_ZLIB),y)
LIBPCIACCESS_CONF_OPTS += -Dzlib=enabled
LIBPCIACCESS_DEPENDENCIES += zlib
else
LIBPCIACCESS_CONF_OPTS += -Dzlib=disabled
endif

$(eval $(meson-package))
