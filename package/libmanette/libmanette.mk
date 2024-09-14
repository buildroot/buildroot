################################################################################
#
# libmanette
#
################################################################################

LIBMANETTE_VERSION_MAJOR = 0.2
LIBMANETTE_VERSION = $(LIBMANETTE_VERSION_MAJOR).9
LIBMANETTE_SOURCE = libmanette-$(LIBMANETTE_VERSION).tar.xz
LIBMANETTE_SITE = https://download.gnome.org/sources/libmanette/$(LIBMANETTE_VERSION_MAJOR)
LIBMANETTE_LICENSE = LGPL-2.1+
LIBMANETTE_LICENSE_FILES = COPYING
LIBMANETTE_INSTALL_STAGING = YES
LIBMANETTE_DEPENDENCIES = \
	libevdev \
	libglib2 \
	$(TARGET_NLS_DEPENDENCIES)

LIBMANETTE_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

LIBMANETTE_CONF_OPTS = \
	-Ddemos=false \
	-Dbuild-tests=false \
	-Dinstall-tests=false \
	-Ddoc=false \
	-Dvapi=false

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBMANETTE_CONF_OPTS += -Dintrospection=true
LIBMANETTE_DEPENDENCIES += gobject-introspection
else
LIBMANETTE_CONF_OPTS += -Dintrospection=false
endif

ifeq ($(BR2_PACKAGE_LIBGUDEV),y)
LIBMANETTE_CONF_OPTS += -Dgudev=enabled
LIBMANETTE_DEPENDENCIES += libgudev
else
LIBMANETTE_CONF_OPTS += -Dgudev=disabled
endif

$(eval $(meson-package))
