################################################################################
#
# xdriver_xf86-video-ast
#
################################################################################

XDRIVER_XF86_VIDEO_AST_VERSION = 1.1.6
XDRIVER_XF86_VIDEO_AST_SOURCE = xf86-video-ast-$(XDRIVER_XF86_VIDEO_AST_VERSION).tar.xz
XDRIVER_XF86_VIDEO_AST_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_AST_LICENSE = MIT
XDRIVER_XF86_VIDEO_AST_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_AST_DEPENDENCIES = xorgproto xserver_xorg-server

$(eval $(autotools-package))
