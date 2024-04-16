################################################################################
#
# xapp_x11perf
#
################################################################################

XAPP_X11PERF_VERSION = 1.6.2
XAPP_X11PERF_SOURCE = x11perf-$(XAPP_X11PERF_VERSION).tar.xz
XAPP_X11PERF_SITE = https://xorg.freedesktop.org/archive/individual/test
XAPP_X11PERF_LICENSE = MIT
XAPP_X11PERF_LICENSE_FILES = COPYING
XAPP_X11PERF_DEPENDENCIES = xlib_libX11 xlib_libXmu xlib_libXft

$(eval $(autotools-package))
