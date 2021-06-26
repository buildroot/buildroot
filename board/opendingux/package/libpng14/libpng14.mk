################################################################################
#
# libpng14
#
################################################################################

LIBPNG14_VERSION = 1.4.22

LIBPNG14_SOURCE = libpng-$(LIBPNG14_VERSION).tar.xz
LIBPNG14_SITE = https://sourceforge.net/projects/libpng/files/libpng14/$(LIBPNG14_VERSION)
LIBPNG14_LICENSE = Libpng-2.0
LIBPNG14_LICENSE_FILES = LICENSE
LIBPNG14_INSTALL_STAGING = NO
LIBPNG14_DEPENDENCIES = host-pkgconf zlib
HOST_LIBPNG14_DEPENDENCIES = host-pkgconf host-zlib
LIBPNG14_CONFIG_SCRIPTS = libpng14-config libpng-config

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
LIBPNG14_CONF_OPTS += --enable-arm-neon
else
LIBPNG14_CONF_OPTS += --disable-arm-neon
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
LIBPNG14_CONF_OPTS += --enable-intel-sse
else
LIBPNG14_CONF_OPTS += --disable-intel-sse
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
