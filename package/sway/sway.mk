################################################################################
#
# sway
#
################################################################################

SWAY_VERSION = 1.7
SWAY_SITE = $(call github,swaywm,sway,v$(SWAY_VERSION))
SWAY_LICENSE = MIT
SWAY_LICENSE_FILES = LICENSE
SWAY_DEPENDENCIES = systemd host-pkgconf wlroots json-c pcre cairo pango
SWAY_CONF_OPTS = \
	-Dwerror=false \
	-Ddefault-wallpaper=false \
	-Dzsh-completions=false \
	-Dbash-completions=false \
	-Dfish-completions=false \
	-Dswaybar=false \
	-Dswaynag=false \
	-Dtray=disabled \
	-Dman-pages=disabled \
	-Dsd-bus-provider=libsystemd

ifeq ($(BR2_PACKAGE_WLROOTS_X11),y)
SWAY_CONF_OPTS += -Dxwayland=enabled
else
SWAY_CONF_OPTS += -Dxwayland=disabled
endif

ifeq ($(BR2_PACKAGE_GDK_PIXBUF),y)
SWAY_CONF_OPTS += -Dgdk-pixbuf=enabled
SWAY_DEPENDENCIES += gdk-pixbuf
else
SWAY_CONF_OPTS += -Dgdk-pixbuf=disabled
endif

$(eval $(meson-package))
