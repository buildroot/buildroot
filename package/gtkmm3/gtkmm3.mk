################################################################################
#
# gtkmm3
#
################################################################################

GTKMM3_VERSION_MAJOR = 3.24
GTKMM3_VERSION = $(GTKMM3_VERSION_MAJOR).10
GTKMM3_SOURCE = gtkmm-$(GTKMM3_VERSION).tar.xz
GTKMM3_SITE = https://download.gnome.org/sources/gtkmm/$(GTKMM3_VERSION_MAJOR)
GTKMM3_LICENSE = LGPL-2.1+ (library), GPL-2.0+ (tools)
GTKMM3_LICENSE_FILES = COPYING COPYING.tools
GTKMM3_INSTALL_STAGING = YES
GTKMM3_DEPENDENCIES = atkmm2_28 cairomm1_14 glibmm2_66 libgtk3 libsigc2 pangomm2_46 host-pkgconf

GTKMM3_CONF_OPTS = \
	-Dbuild-demos=false \
	-Dbuild-tests=false

ifeq ($(BR2_PACKAGE_LIBGTK3_X11),y)
GTKMM3_CONF_OPTS += -Dbuild-x11-api=true
else
GTKMM3_CONF_OPTS += -Dbuild-x11-api=false
endif

$(eval $(meson-package))
