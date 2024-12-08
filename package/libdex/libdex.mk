################################################################################
#
# libdex
#
################################################################################

# The middle number is even for stable releases, odd for development ones.
LIBDEX_VERSION_MAJOR = 0.8
LIBDEX_VERSION = $(LIBDEX_VERSION_MAJOR).1
LIBDEX_SOURCE = libdex-$(LIBDEX_VERSION).tar.xz
LIBDEX_SITE = https://download.gnome.org/sources/libdex/$(LIBDEX_VERSION_MAJOR)
LIBDEX_LICENSE = LGPL-2.1+
LIBDEX_LICENSE_FILES = COPYING
LIBDEX_INSTALL_STAGING = YES
LIBDEX_DEPENDENCIES = libglib2
LIBDEX_CONF_OPTS = \
	-Ddocs=false \
	-Dexamples=false \
	-Dstack-protector=false \
	-Dsysprof=false \
	-Dtests=false \
	-Dvapi=false \
	-Deventfd=enabled \
	-Dintrospection=disabled

ifeq ($(BR2_PACKAGE_LIBUCONTEXT),y)
LIBDEX_DEPENDENCIES += libucontext
LIBDEX_LDFLAGS += $(TARGET_LDFLAGS) -lucontext
endif

ifeq ($(BR2_PACKAGE_LIBURING),y)
LIBDEX_CONF_OPTS += -Dliburing=enabled
LIBDEX_DEPENDENCIES += liburing
else
LIBDEX_CONF_OPTS += -Dliburing=disabled
endif

$(eval $(meson-package))
