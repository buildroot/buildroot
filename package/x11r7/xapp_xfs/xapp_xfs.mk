################################################################################
#
# xapp_xfs
#
################################################################################

XAPP_XFS_VERSION = 1.2.1
XAPP_XFS_SOURCE = xfs-$(XAPP_XFS_VERSION).tar.xz
XAPP_XFS_SITE = https://xorg.freedesktop.org/releases/individual/app
XAPP_XFS_LICENSE = MIT
XAPP_XFS_LICENSE_FILES = COPYING
XAPP_XFS_DEPENDENCIES = xlib_libFS xlib_libXfont2 xorgproto

$(eval $(autotools-package))
