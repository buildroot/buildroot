################################################################################
#
# xdriver_xf86-video-openchrome
#
################################################################################

XDRIVER_XF86_VIDEO_OPENCHROME_VERSION = ab03de703b91c7e0fd3e4d1ca06ad5add7f077a1
XDRIVER_XF86_VIDEO_OPENCHROME_SITE = https://anongit.freedesktop.org/git/openchrome/xf86-video-openchrome.git
XDRIVER_XF86_VIDEO_OPENCHROME_SITE_METHOD = git
XDRIVER_XF86_VIDEO_OPENCHROME_LICENSE = MIT
XDRIVER_XF86_VIDEO_OPENCHROME_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_OPENCHROME_AUTORECONF = YES

XDRIVER_XF86_VIDEO_OPENCHROME_DEPENDENCIES = \
	xserver_xorg-server \
	libdrm \
	xlib_libX11 \
	xlib_libXcomposite \
	xlib_libXvMC \
	xorgproto

$(eval $(autotools-package))
