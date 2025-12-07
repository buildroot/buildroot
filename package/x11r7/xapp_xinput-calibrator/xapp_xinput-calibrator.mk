################################################################################
#
# xapp_xinput-calibrator
#
################################################################################

XAPP_XINPUT_CALIBRATOR_VERSION = 0.8.0
XAPP_XINPUT_CALIBRATOR_SOURCE = xinput_calibrator-$(XAPP_XINPUT_CALIBRATOR_VERSION).tar.xz
XAPP_XINPUT_CALIBRATOR_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XINPUT_CALIBRATOR_LICENSE = MIT
XAPP_XINPUT_CALIBRATOR_LICENSE_FILES = COPYING
XAPP_XINPUT_CALIBRATOR_DEPENDENCIES = xlib_libX11 xlib_libXi

$(eval $(autotools-package))
