################################################################################
#
# libgtk4
#
################################################################################

LIBGTK4_VERSION_MAJOR = 4.14
LIBGTK4_VERSION = $(LIBGTK4_VERSION_MAJOR).5
LIBGTK4_SOURCE = gtk-$(LIBGTK4_VERSION).tar.xz
LIBGTK4_SITE = https://download.gnome.org/sources/gtk/$(LIBGTK4_VERSION_MAJOR)
LIBGTK4_LICENSE = LGPL-2.0+
LIBGTK4_LICENSE_FILES = COPYING
LIBGTK4_CPE_ID_VENDOR = gnome
LIBGTK4_CPE_ID_PRODUCT = gtk
LIBGTK4_INSTALL_STAGING = YES

LIBGTK4_DEPENDENCIES = \
	host-pkgconf \
	host-libgtk4 \
	gdk-pixbuf \
	graphene \
	libepoxy \
	libglib2 \
	pango \
	$(TARGET_NLS_DEPENDENCIES)

LIBGTK4_CONF_OPTS = \
	-Dbuild-tests=false \
	-Dbuild-testsuite=false \
	-Dprint-cpdb=disabled \
	-Dvulkan=disabled \
	-Dcloudproviders=disabled \
	-Dsysprof=disabled \
	-Dtracker=disabled \
	-Dcolord=disabled \
	-Dintrospection=disabled \
	-Ddocumentation=false \
	-Dscreenshots=false \
	-Dman-pages=false

ifeq ($(BR2_PACKAGE_LIBGTK4_X11),y)
LIBGTK4_DEPENDENCIES += xlib_libXcursor xlib_libXi xlib_libXinerama
LIBGTK4_CONF_OPTS += -Dx11-backend=true
else
LIBGTK4_CONF_OPTS += -Dx11-backend=false
endif

ifeq ($(BR2_PACKAGE_LIBGTK4_WAYLAND),y)
LIBGTK4_DEPENDENCIES += wayland wayland-protocols libxkbcommon
LIBGTK4_CONF_OPTS += -Dwayland-backend=true
else
LIBGTK4_CONF_OPTS += -Dwayland-backend=false
endif

ifeq ($(BR2_PACKAGE_LIBGTK4_BROADWAY),y)
LIBGTK4_CONF_OPTS += -Dbroadway-backend=true
else
LIBGTK4_CONF_OPTS += -Dbroadway-backend=false
endif

ifeq ($(BR2_PACKAGE_LIBGTK4_GSTREAMER),y)
LIBGTK4_CONF_OPTS += -Dmedia-gstreamer=enabled
LIBGTK4_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-bad
else
LIBGTK4_CONF_OPTS += -Dmedia-gstreamer=disabled
endif

ifeq ($(BR2_PACKAGE_CUPS),y)
LIBGTK4_CONF_OPTS += -Dprint-cups=enabled
LIBGTK4_DEPENDENCIES += cups
else
LIBGTK4_CONF_OPTS += -Dprint-cups=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGTK4_DEMO),y)
LIBGTK4_CONF_OPTS += -Dbuild-demos=true -Dbuild-examples=true
LIBGTK4_DEPENDENCIES += hicolor-icon-theme shared-mime-info
else
LIBGTK4_CONF_OPTS += -Dbuild-demos=false -Dbuild-examples=false
endif

define LIBGTK4_COMPILE_GLIB_SCHEMAS
	$(HOST_DIR)/bin/glib-compile-schemas \
		$(TARGET_DIR)/usr/share/glib-2.0/schemas
endef
LIBGTK4_POST_INSTALL_TARGET_HOOKS += LIBGTK4_COMPILE_GLIB_SCHEMAS

# here, we build a native gtk4-update-icon-cache as host-libgtk4

HOST_LIBGTK4_DEPENDENCIES = \
	host-gdk-pixbuf \
	host-libglib2 \
	host-pkgconf

HOST_LIBGTK4_CFLAGS = \
	-I $(@D)/gtk \
	`$(HOST_MAKE_ENV) $(PKG_CONFIG_HOST_BINARY) --cflags --libs gdk-pixbuf-2.0`

define HOST_LIBGTK4_CONFIGURE_CMDS
	echo "#define BUILD_TOOLS 1" >> $(@D)/gtk/config.h
	echo "#define GETTEXT_PACKAGE \"gtk40\"" >> $(@D)/gtk/config.h
	echo "#define GTK_LOCALEDIR \"/usr/share/locale\"" >> $(@D)/gtk/config.h
	echo "#define HAVE_UNISTD_H 1" >> $(@D)/gtk/config.h
	echo "#define HAVE_FTW_H 1" >> $(@D)/gtk/config.h
endef

define HOST_LIBGTK4_BUILD_CMDS
	$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) \
		$(@D)/tools/updateiconcache.c $(@D)/gtk/gtkiconcachevalidator.c\
		$(HOST_LIBGTK4_CFLAGS) \
		-o $(@D)/tools/gtk4-update-icon-cache
endef

define HOST_LIBGTK4_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/tools/gtk4-update-icon-cache \
		$(HOST_DIR)/bin/gtk4-update-icon-cache
endef

# Create icon-theme.cache for each of the icon directories/themes
# It's not strictly necessary but speeds up lookups
define LIBGTK4_UPDATE_ICON_CACHE
	[ ! -d $(TARGET_DIR)/usr/share/icons ] || \
		find $(TARGET_DIR)/usr/share/icons -maxdepth 1 -mindepth 1 -type d \
			-exec $(HOST_DIR)/bin/gtk-update-icon-cache {} \;
endef
LIBGTK4_TARGET_FINALIZE_HOOKS += LIBGTK4_UPDATE_ICON_CACHE

$(eval $(meson-package))
$(eval $(host-generic-package))
