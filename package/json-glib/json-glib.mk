################################################################################
#
# json-glib
#
################################################################################

JSON_GLIB_VERSION_MAJOR = 1.10
JSON_GLIB_VERSION = $(JSON_GLIB_VERSION_MAJOR).6
JSON_GLIB_SITE = https://download.gnome.org/sources/json-glib/$(JSON_GLIB_VERSION_MAJOR)
JSON_GLIB_SOURCE = json-glib-$(JSON_GLIB_VERSION).tar.xz
JSON_GLIB_LICENSE = LGPL-2.1+, MIT (conformance test data), CC0-1.0 (parts of build system, metadata, translations)
JSON_GLIB_LICENSE_FILES = LICENSES/CC0-1.0.txt \
	LICENSES/LGPL-2.1-or-later.txt \
	LICENSES/MIT.txt \
	COPYING
JSON_GLIB_INSTALL_STAGING = YES
JSON_GLIB_CONF_OPTS = -Dgtk_doc=disabled -Dtests=false

JSON_GLIB_DEPENDENCIES = \
	$(TARGET_NLS_DEPENDENCIES) \
	host-pkgconf \
	libglib2

HOST_JSON_GLIB_DEPENDENCIES = \
	host-pkgconf \
	host-libglib2

HOST_JSON_GLIB_CONF_OPTS = \
	-Dgtk_doc=disabled \
	-Dtests=false \
	-Dintrospection=disabled

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
JSON_GLIB_CONF_OPTS += -Dintrospection=enabled
JSON_GLIB_DEPENDENCIES += gobject-introspection
else
JSON_GLIB_CONF_OPTS += -Dintrospection=disabled
endif

ifeq ($(BR2_SYSTEM_ENABLE_NLS),y)
JSON_GLIB_CONF_OPTS += -Dnls=enabled
else
JSON_GLIB_CONF_OPTS += -Dnls=disabled
endif

JSON_GLIB_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

$(eval $(meson-package))
$(eval $(host-meson-package))
