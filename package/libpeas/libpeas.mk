################################################################################
#
# libpeas
#
################################################################################

LIBPEAS_VERSION_MAJOR = 1.32
LIBPEAS_VERSION = $(LIBPEAS_VERSION_MAJOR).0
LIBPEAS_SOURCE = libpeas-$(LIBPEAS_VERSION).tar.xz
LIBPEAS_SITE = https://download.gnome.org/sources/libpeas/$(LIBPEAS_VERSION_MAJOR)
LIBPEAS_LICENSE = LGPL-2.1+
LIBPEAS_LICENSE_FILES = COPYING
LIBPEAS_CPE_ID_VENDOR = gnome
LIBPEAS_INSTALL_STAGING = YES
LIBPEAS_DEPENDENCIES = \
	host-libglib2 \
	host-pkgconf \
	gobject-introspection \
	libglib2 \
	$(TARGET_NLS_DEPENDENCIES)

LIBPEAS_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

LIBPEAS_CONF_OPTS = \
	-Ddemos=false \
	-Dglade_catalog=false \
	-Dgtk_doc=false \
	-Dintrospection=true \
	-Dlua51=false \
	-Dpython2=false \
	-Dpython3=false \
	-Dvapi=false

ifeq ($(BR2_PACKAGE_LIBPEAS_WIDGETS),y)
LIBPEAS_DEPENDENCIES += libgtk3
LIBPEAS_CONF_OPTS += -Dwidgetry=true
else
LIBPEAS_CONF_OPTS += -Dwidgetry=false
endif

$(eval $(meson-package))
