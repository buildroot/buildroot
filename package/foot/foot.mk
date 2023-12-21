################################################################################
#
# foot
#
################################################################################

FOOT_VERSION = 1.16.2
FOOT_SOURCE = $(FOOT_VERSION).tar.gz
FOOT_SITE = https://codeberg.org/dnkl/foot/archive
FOOT_LICENSE = MIT
FOOT_LICENSE_FILES = LICENSE
FOOT_DEPENDENCIES = \
	fcft \
	fontconfig \
	freetype \
	libxkbcommon \
	pixman \
	tllist \
	wayland \
	wayland-protocols

FOOT_CONF_OPTS = \
	-Ddocs=disabled \
	-Dtests=false

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
FOOT_DEPENDENCIES += systemd
endif

ifeq ($(BR2_PACKAGE_LIBUTEMPTER),y)
FOOT_DEPENDENCIES += libutempter
FOOT_CONF_OPTS += -Dutmp-backend='libutempter'
else
FOOT_CONF_OPTS += -Dutmp-backend='none'
endif

ifeq ($(BR2_PACKAGE_FOOT_GRAPHEME_CLUSTERING),y)
FOOT_DEPENDENCIES += utf8proc
FOOT_CONF_OPTS += -Dgrapheme-clustering=enabled
else
FOOT_CONF_OPTS += -Dgrapheme-clustering=disabled
endif

ifeq ($(BR2_PACKAGE_FOOT_THEMES),y)
FOOT_CONF_OPTS += -Dthemes=true
else
FOOT_CONF_OPTS += -Dthemes=false
endif

$(eval $(meson-package))
