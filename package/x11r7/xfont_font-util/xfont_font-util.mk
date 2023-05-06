################################################################################
#
# xfont_font-util
#
################################################################################

XFONT_FONT_UTIL_VERSION = 1.4.0
XFONT_FONT_UTIL_SOURCE = font-util-$(XFONT_FONT_UTIL_VERSION).tar.xz
XFONT_FONT_UTIL_SITE = https://xorg.freedesktop.org/archive/individual/font
XFONT_FONT_UTIL_LICENSE = MIT/BSD-2-Clause
XFONT_FONT_UTIL_LICENSE_FILES = COPYING

XFONT_FONT_UTIL_DEPENDENCIES = host-pkgconf
HOST_XFONT_FONT_UTIL_DEPENDENCIES = host-pkgconf
XFONT_FONT_UTIL_INSTALL_STAGING = YES
XFONT_FONT_UTIL_INSTALL_TARGET = NO

$(eval $(autotools-package))
$(eval $(host-autotools-package))
