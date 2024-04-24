################################################################################
#
# libxmlb
#
################################################################################

LIBXMLB_VERSION = 0.3.19
LIBXMLB_SITE = $(call github,hughsie,libxmlb,$(LIBXMLB_VERSION))
LIBXMLB_LICENSE = LGPL-2.1+
LIBXMLB_LICENSE_FILES = LICENSE
LIBXMLB_INSTALL_STAGING = YES
LIBXMLB_DEPENDENCIES = libglib2
LIBXMLB_CONF_OPTS = -Dgtkdoc=false -Dtests=false

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBXMLB_CONF_OPTS += -Dintrospection=true
LIBXMLB_DEPENDENCIES += gobject-introspection
else
LIBXMLB_CONF_OPTS += -Dintrospection=false
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
LIBXMLB_DEPENDENCIES += zstd
LIBXMLB_CONF_OPTS += -Dzstd=enabled
else
LIBXMLB_CONF_OPTS += -Dzstd=disabled
endif

ifeq ($(BR2_PACKAGE_XZ),y)
LIBXMLB_DEPENDENCIES += xz
LIBXMLB_CONF_OPTS += -Dlzma=enabled
else
LIBXMLB_CONF_OPTS += -Dlzma=disabled
endif

$(eval $(meson-package))
