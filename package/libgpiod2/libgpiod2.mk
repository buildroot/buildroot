################################################################################
#
# libgpiod2
#
################################################################################

# Be careful when bumping versions.
# Dependency on kernel header versions may change.
LIBGPIOD2_VERSION = 2.3.1
LIBGPIOD2_SOURCE = libgpiod-$(LIBGPIOD2_VERSION).tar.xz
LIBGPIOD2_SITE = https://www.kernel.org/pub/software/libs/libgpiod
LIBGPIOD2_LICENSE = LGPL-2.1+
LIBGPIOD2_LICENSE_FILES = COPYING
LIBGPIOD2_INSTALL_STAGING = YES
LIBGPIOD2_DEPENDENCIES = host-pkgconf
LIBGPIOD2_CONF_OPTS = \
	-Dbindings-python=disabled \
	-Dexamples=disabled \
	-Dtests=disabled

ifeq ($(BR2_PACKAGE_LIBGPIOD2_DBUS),y)
LIBGPIOD2_CONF_OPTS += -Ddbus=enabled
LIBGPIOD2_DEPENDENCIES += libgudev
else
LIBGPIOD2_CONF_OPTS += -Ddbus=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGPIOD2_TOOLS),y)
LIBGPIOD2_CONF_OPTS += -Dtools=enabled
else
LIBGPIOD2_CONF_OPTS += -Dtools=disabled
endif

ifeq ($(BR2_PACKAGE_LIBEDIT),y)
LIBGPIOD2_DEPENDENCIES += libedit
LIBGPIOD2_CONF_OPTS += -Dgpioset-interactive=enabled
else
LIBGPIOD2_CONF_OPTS += -Dgpioset-interactive=disabled
endif

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
LIBGPIOD2_CONF_OPTS += -Dbindings-cxx=enabled
else
LIBGPIOD2_CONF_OPTS += -Dbindings-cxx=disabled
endif

$(eval $(meson-package))
