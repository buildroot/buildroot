################################################################################
#
# swaybg
#
################################################################################

SWAYBG_VERSION = 1.2.0
SWAYBG_SITE = https://github.com/swaywm/swaybg/releases/download/v$(SWAYBG_VERSION)
SWAYBG_LICENSE = MIT
SWAYBG_LICENSE_FILES = LICENSE

SWAYBG_DEPENDENCIES = \
	cairo \
	wayland \
	wayland-protocols

SWAYBG_CONF_OPTS = \
	-Dman-pages=disabled \
	-Dwerror=false

ifeq ($(BR2_PACKAGE_GDK_PIXBUF),y)
SWAYBG_CONF_OPTS += -Dgdk-pixbuf=enabled
SWAYBG_DEPENDENCIES += gdk-pixbuf
else
SWAYBG_CONF_OPTS += -Dgdk-pixbuf=disabled
endif

$(eval $(meson-package))
