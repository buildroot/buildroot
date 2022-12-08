################################################################################
#
# xlib_libXdmcp
#
################################################################################

XLIB_LIBXDMCP_VERSION = 1.1.4
XLIB_LIBXDMCP_SOURCE = libXdmcp-$(XLIB_LIBXDMCP_VERSION).tar.xz
XLIB_LIBXDMCP_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXDMCP_LICENSE = MIT
XLIB_LIBXDMCP_LICENSE_FILES = COPYING
XLIB_LIBXDMCP_CPE_ID_VENDOR = x.org
XLIB_LIBXDMCP_CPE_ID_PRODUCT = libxdmcp
XLIB_LIBXDMCP_INSTALL_STAGING = YES
XLIB_LIBXDMCP_DEPENDENCIES = xutil_util-macros xorgproto host-pkgconf
HOST_XLIB_LIBXDMCP_DEPENDENCIES = host-xutil_util-macros host-xorgproto host-pkgconf

$(eval $(autotools-package))
$(eval $(host-autotools-package))
