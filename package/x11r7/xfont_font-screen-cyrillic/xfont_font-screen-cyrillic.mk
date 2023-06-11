################################################################################
#
# xfont_font-screen-cyrillic
#
################################################################################

XFONT_FONT_SCREEN_CYRILLIC_VERSION = 1.0.5
XFONT_FONT_SCREEN_CYRILLIC_SOURCE = font-screen-cyrillic-$(XFONT_FONT_SCREEN_CYRILLIC_VERSION).tar.xz
XFONT_FONT_SCREEN_CYRILLIC_SITE = https://xorg.freedesktop.org/archive/individual/font
XFONT_FONT_SCREEN_CYRILLIC_LICENSE = MIT
XFONT_FONT_SCREEN_CYRILLIC_LICENSE_FILES = COPYING

XFONT_FONT_SCREEN_CYRILLIC_INSTALL_STAGING_OPTS = DESTDIR=$(STAGING_DIR) MKFONTSCALE=$(HOST_DIR)/bin/mkfontscale MKFONTDIR=$(HOST_DIR)/bin/mkfontdir install
XFONT_FONT_SCREEN_CYRILLIC_INSTALL_TARGET_OPTS = DESTDIR=$(TARGET_DIR) MKFONTSCALE=$(HOST_DIR)/bin/mkfontscale MKFONTDIR=$(HOST_DIR)/bin/mkfontdir install-data
XFONT_FONT_SCREEN_CYRILLIC_DEPENDENCIES = \
	xfont_font-util \
	host-xfont_font-util \
	host-xapp_mkfontscale \
	host-xapp_bdftopcf \
	host-gzip

$(eval $(autotools-package))
