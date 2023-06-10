################################################################################
#
# libgtk3
#
################################################################################

LIBGTK3_VERSION_MAJOR = 3.24
LIBGTK3_VERSION = $(LIBGTK3_VERSION_MAJOR).38
LIBGTK3_SOURCE = gtk+-$(LIBGTK3_VERSION).tar.xz
LIBGTK3_SITE = https://download.gnome.org/sources/gtk+/$(LIBGTK3_VERSION_MAJOR)
LIBGTK3_LICENSE = LGPL-2.0+
LIBGTK3_LICENSE_FILES = COPYING
LIBGTK3_CPE_ID_VENDOR = gnome
LIBGTK3_CPE_ID_PRODUCT = gtk
LIBGTK3_INSTALL_STAGING = YES

LIBGTK3_DEPENDENCIES = host-pkgconf host-libgtk3 atk libglib2 cairo pango \
	gdk-pixbuf libepoxy $(TARGET_NLS_DEPENDENCIES)

ifeq ($(BR2_PACKAGE_LIBGTK3_X11),y)
LIBGTK3_DEPENDENCIES += fontconfig xlib_libX11 xlib_libXext xlib_libXrandr xlib_libXrender xlib_libXi
LIBGTK3_CONF_OPTS += -Dx11_backend=true
else
LIBGTK3_CONF_OPTS += -Dx11_backend=false
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBGTK3_CONF_OPTS += -Dintrospection=true
LIBGTK3_DEPENDENCIES += gobject-introspection
else
LIBGTK3_CONF_OPTS += -Dintrospection=false
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_WAYLAND),y)
LIBGTK3_DEPENDENCIES += wayland wayland-protocols libxkbcommon
LIBGTK3_CONF_OPTS += -Dwayland_backend=true
else
LIBGTK3_CONF_OPTS += -Dwayland_backend=false
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_BROADWAY),y)
LIBGTK3_CONF_OPTS += -Dbroadway_backend=true
else
LIBGTK3_CONF_OPTS += -Dbroadway_backend=false
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXINERAMA),y)
LIBGTK3_CONF_OPTS += -Dxinerama=yes
LIBGTK3_DEPENDENCIES += xlib_libXinerama
else
LIBGTK3_CONF_OPTS += -Dxinerama=no
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXCURSOR),y)
LIBGTK3_DEPENDENCIES += xlib_libXcursor
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXFIXES),y)
LIBGTK3_DEPENDENCIES += xlib_libXfixes
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXCOMPOSITE),y)
LIBGTK3_DEPENDENCIES += xlib_libXcomposite
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXDAMAGE),y)
LIBGTK3_DEPENDENCIES += xlib_libXdamage
endif

ifeq ($(BR2_PACKAGE_CUPS),y)
LIBGTK3_CONF_OPTS += -Dprint_backends=file,cups
LIBGTK3_DEPENDENCIES += cups
else
LIBGTK3_CONF_OPTS += -Dprint_backends=auto
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_DEMO),y)
LIBGTK3_CONF_OPTS += -Ddemos=true -Dexamples=true
LIBGTK3_DEPENDENCIES += hicolor-icon-theme shared-mime-info
else
LIBGTK3_CONF_OPTS += -Ddemos=false -Dexamples=false
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_TESTS),y)
LIBGTK3_CONF_OPTS += -Dtests=true -Dinstalled_tests=true
else
LIBGTK3_CONF_OPTS += -Dtests=false -Dinstalled_tests=false
endif

define LIBGTK3_COMPILE_GLIB_SCHEMAS
	$(HOST_DIR)/bin/glib-compile-schemas \
		$(TARGET_DIR)/usr/share/glib-2.0/schemas
endef

LIBGTK3_POST_INSTALL_TARGET_HOOKS += LIBGTK3_COMPILE_GLIB_SCHEMAS

# gtk+ >= 3.10 can build a native version of gtk-update-icon-cache if
# --enable-gtk2-dependency=no is set when invoking './configure'.
#
# Unfortunately, if the target toolchain is based on uClibc, the macro
# AM_GLIB_GNU_GETTEXT will detect the libintl built for the target and
# will add '-lintl' to the default list of libraries for the linker (used
# for both native and target builds).
#
# But no native version of libintl is available (the functions are
# provided by glibc). So gtk-update-icon-cache will not build.
#
# As a workaround, we build gtk-update-icon-cache on our own, set
# --enable-gtk2-dependency=yes and force './configure' to use our version.

HOST_LIBGTK3_DEPENDENCIES = \
	host-libglib2 \
	host-libpng \
	host-gdk-pixbuf \
	host-pkgconf \
	host-librsvg

HOST_LIBGTK3_CFLAGS = \
	`$(HOST_MAKE_ENV) $(PKG_CONFIG_HOST_BINARY) --cflags --libs gdk-pixbuf-2.0` \
	`$(HOST_MAKE_ENV) $(PKG_CONFIG_HOST_BINARY) --cflags --libs gio-2.0`

define HOST_LIBGTK3_CONFIGURE_CMDS
	echo "#define GETTEXT_PACKAGE \"gtk30\"" >> $(@D)/gtk/config.h
	echo "#define HAVE_UNISTD_H 1" >> $(@D)/gtk/config.h
	echo "#define HAVE_FTW_H 1" >> $(@D)/gtk/config.h
endef

define HOST_LIBGTK3_BUILD_CMDS
	$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) \
		$(@D)/gtk/updateiconcache.c \
		$(HOST_LIBGTK3_CFLAGS) \
		-o $(@D)/gtk/gtk-update-icon-cache
	$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) \
		$(@D)/gtk/encodesymbolic.c \
		$(HOST_LIBGTK3_CFLAGS) \
		-o $(@D)/gtk/gtk-encode-symbolic-svg
endef

define HOST_LIBGTK3_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/gtk/gtk-update-icon-cache \
		$(HOST_DIR)/bin/gtk-update-icon-cache
	$(INSTALL) -D -m 0755 $(@D)/gtk/gtk-encode-symbolic-svg \
		$(HOST_DIR)/bin/gtk-encode-symbolic-svg
endef

# Create icon-theme.cache for each of the icon directories/themes
# It's not strictly necessary but speeds up lookups
define LIBGTK3_UPDATE_ICON_CACHE
	[ ! -d $(TARGET_DIR)/usr/share/icons ] || \
		find $(TARGET_DIR)/usr/share/icons -maxdepth 1 -mindepth 1 -type d \
			-exec $(HOST_DIR)/bin/gtk-update-icon-cache {} \;
endef
LIBGTK3_TARGET_FINALIZE_HOOKS += LIBGTK3_UPDATE_ICON_CACHE

$(eval $(meson-package))
$(eval $(host-generic-package))
