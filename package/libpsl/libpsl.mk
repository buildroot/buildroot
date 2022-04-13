################################################################################
#
# libpsl
#
################################################################################

LIBPSL_VERSION = 0.21.1
LIBPSL_SITE = https://github.com/rockdaboot/libpsl/releases/download/$(LIBPSL_VERSION)
LIBPSL_LICENSE = MIT, BSD-3-Clause
LIBPSL_LICENSE_FILES = COPYING src/LICENSE.chromium
LIBPSL_DEPENDENCIES = host-pkgconf
LIBPSL_INSTALL_STAGING = YES

# The order of checks is the same as done by libpsl when configured.
ifeq ($(BR2_PACKAGE_LIBIDN2)$(BR2_PACKAGE_LIBUNISTRING),yy)
LIBPSL_CONF_OPTS += -Druntime=libidn2 -Dbuiltin=libidn2
LIBPSL_DEPENDENCIES += libidn2 libunistring
else ifeq ($(BR2_PACKAGE_ICU),y)
LIBPSL_CONF_OPTS += -Druntime=libicu -Dbuiltin=libicu
LIBPSL_DEPENDENCIES += icu
else
LIBPSL_CONF_OPTS += -Druntime=libidn -Dbuiltin=libidn
LIBPSL_DEPENDENCIES += libidn libunistring
endif

$(eval $(meson-package))
