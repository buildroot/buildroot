################################################################################
#
# fcft
#
################################################################################

FCFT_VERSION = 3.1.6
FCFT_SOURCE = $(FCFT_VERSION).tar.gz
FCFT_SITE = https://codeberg.org/dnkl/fcft/archive
FCFT_LICENSE = MIT
FCFT_LICENSE_FILES = LICENSE
FCFT_INSTALL_STAGING = YES

FCFT_DEPENDENCIES = \
	fontconfig \
	freetype \
	pixman \
	tllist

FCFT_CONF_OPTS = \
	-Ddocs=disabled \
	-Dexamples=false

ifeq ($(BR2_PACKAGE_FCFT_GRAPHEME_SHAPING),y)
FCFT_DEPENDENCIES += harfbuzz
FCFT_CONF_OPTS += -Dgrapheme-shaping=enabled
else
FCFT_CONF_OPTS += -Dgrapheme-shaping=disabled
endif

ifeq ($(BR2_PACKAGE_FCFT_RUN_SHAPING),y)
FCFT_DEPENDENCIES += harfbuzz utf8proc
FCFT_CONF_OPTS += -Drun-shaping=enabled
else
FCFT_CONF_OPTS += -Drun-shaping=disabled
endif

ifeq ($(BR2_PACKAGE_FCFT_SVG_SUPPORT),y)
FCFT_CONF_OPTS += -Dsvg-backend='nanosvg'
else
FCFT_CONF_OPTS += -Dsvg-backend='none'
endif

$(eval $(meson-package))
