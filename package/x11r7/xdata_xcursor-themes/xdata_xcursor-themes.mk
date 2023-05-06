################################################################################
#
# xdata_xcursor-themes
#
################################################################################

XDATA_XCURSOR_THEMES_VERSION = 1.0.7
XDATA_XCURSOR_THEMES_SOURCE = xcursor-themes-$(XDATA_XCURSOR_THEMES_VERSION).tar.xz
XDATA_XCURSOR_THEMES_SITE = https://xorg.freedesktop.org/archive/individual/data
XDATA_XCURSOR_THEMES_LICENSE = MIT
XDATA_XCURSOR_THEMES_LICENSE_FILES = COPYING

XDATA_XCURSOR_THEMES_INSTALL_STAGING = YES
XDATA_XCURSOR_THEMES_DEPENDENCIES = xlib_libXcursor host-xapp_xcursorgen

$(eval $(autotools-package))
