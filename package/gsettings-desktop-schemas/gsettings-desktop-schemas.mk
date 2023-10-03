################################################################################
#
# gsettings-desktop-schemas
#
################################################################################

GSETTINGS_DESKTOP_SCHEMAS_VERSION_MAJOR = 45
GSETTINGS_DESKTOP_SCHEMAS_VERSION = $(GSETTINGS_DESKTOP_SCHEMAS_VERSION_MAJOR).0
GSETTINGS_DESKTOP_SCHEMAS_SOURCE = gsettings-desktop-schemas-$(GSETTINGS_DESKTOP_SCHEMAS_VERSION).tar.xz
GSETTINGS_DESKTOP_SCHEMAS_SITE = https://download.gnome.org/sources/gsettings-desktop-schemas/$(GSETTINGS_DESKTOP_SCHEMAS_VERSION_MAJOR)
GSETTINGS_DESKTOP_SCHEMAS_INSTALL_STAGING = YES
GSETTINGS_DESKTOP_SCHEMAS_DEPENDENCIES = host-pkgconf libglib2
GSETTINGS_DESKTOP_SCHEMAS_LICENSE = LGPL-2.1+
GSETTINGS_DESKTOP_SCHEMAS_LICENSE_FILES = COPYING
GSETTINGS_DESKTOP_SCHEMAS_CONF_OPTS = -Dintrospection=false

$(eval $(meson-package))
