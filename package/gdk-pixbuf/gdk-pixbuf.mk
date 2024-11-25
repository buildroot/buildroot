################################################################################
#
# gdk-pixbuf
#
################################################################################

GDK_PIXBUF_VERSION_MAJOR = 2.42
GDK_PIXBUF_VERSION = $(GDK_PIXBUF_VERSION_MAJOR).12
GDK_PIXBUF_SOURCE = gdk-pixbuf-$(GDK_PIXBUF_VERSION).tar.xz
GDK_PIXBUF_SITE = https://download.gnome.org/sources/gdk-pixbuf/$(GDK_PIXBUF_VERSION_MAJOR)
GDK_PIXBUF_LICENSE = LGPL-2.1+
GDK_PIXBUF_LICENSE_FILES = COPYING
GDK_PIXBUF_CPE_ID_VENDOR = gnome
GDK_PIXBUF_INSTALL_STAGING = YES
GDK_PIXBUF_DEPENDENCIES = \
	host-gdk-pixbuf host-libglib2 host-pkgconf \
	libglib2 $(if $(BR2_ENABLE_LOCALE),,libiconv)
HOST_GDK_PIXBUF_DEPENDENCIES = host-libpng host-pkgconf host-libglib2

GDK_PIXBUF_CONF_OPTS = \
	-Dgio_sniffing=false \
	-Dtests=false \
	-Dinstalled_tests=false \
	-Dman=false

HOST_GDK_PIXBUF_CONF_OPTS = \
	-Dgio_sniffing=false \
	-Dtests=false \
	-Dinstalled_tests=false \
	-Dintrospection=disabled \
	-Drelocatable=true \
	-Dman=false

ifeq ($(BR2_STATIC_LIBS),y)
GDK_PIXBUF_CONF_OPTS += -Dbuiltin_loaders=all
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
GDK_PIXBUF_CONF_OPTS += -Dintrospection=enabled
GDK_PIXBUF_DEPENDENCIES += gobject-introspection
else
GDK_PIXBUF_CONF_OPTS += -Dintrospection=disabled
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
GDK_PIXBUF_CONF_OPTS += -Dpng=enabled
GDK_PIXBUF_DEPENDENCIES += libpng
else
GDK_PIXBUF_CONF_OPTS += -Dpng=disabled
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
GDK_PIXBUF_CONF_OPTS += -Djpeg=enabled
HOST_GDK_PIXBUF_CONF_OPTS += -Djpeg=enabled
GDK_PIXBUF_DEPENDENCIES += jpeg
HOST_GDK_PIXBUF_DEPENDENCIES += host-libjpeg
else
GDK_PIXBUF_CONF_OPTS += -Djpeg=disabled
HOST_GDK_PIXBUF_CONF_OPTS += -Djpeg=disabled
endif

ifeq ($(BR2_PACKAGE_TIFF),y)
GDK_PIXBUF_CONF_OPTS += -Dtiff=enabled
HOST_GDK_PIXBUF_CONF_OPTS += -Dtiff=enabled
GDK_PIXBUF_DEPENDENCIES += tiff
HOST_GDK_PIXBUF_DEPENDENCIES += host-tiff
else
GDK_PIXBUF_CONF_OPTS += -Dtiff=disabled
HOST_GDK_PIXBUF_CONF_OPTS += -Dtiff=disabled
endif

# gdk-pixbuf requires the loaders.cache file populated to work properly
# Rather than doing so at runtime, since the fs can be read-only, do so
# here after building and installing to target.
# And since the cache file will contain relative host directory names we
# need to prepend them with /usr/.
ifeq ($(BR2_STATIC_LIBS),)
define GDK_PIXBUF_UPDATE_CACHE
	GDK_PIXBUF_MODULEDIR=$(HOST_DIR)/lib/gdk-pixbuf-2.0/2.10.0/loaders \
		$(HOST_DIR)/bin/gdk-pixbuf-query-loaders \
		> $(TARGET_DIR)/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache
	$(SED) 's,^"lib,"/usr/lib,g' \
		$(TARGET_DIR)/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache
endef
GDK_PIXBUF_POST_INSTALL_TARGET_HOOKS += GDK_PIXBUF_UPDATE_CACHE
endif

# Target gdk-pixbuf needs loaders.cache populated to build for the
# thumbnailer. Use the host-built since it matches the target options
# regarding mime types (which is the used information).
define GDK_PIXBUF_COPY_LOADERS_CACHE
	cp -f $(HOST_DIR)/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache \
		$(@D)/gdk-pixbuf
endef
GDK_PIXBUF_PRE_BUILD_HOOKS += GDK_PIXBUF_COPY_LOADERS_CACHE

$(eval $(meson-package))
$(eval $(host-meson-package))
