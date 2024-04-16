################################################################################
#
# xapp_xinit
#
################################################################################

XAPP_XINIT_VERSION = 1.4.2
XAPP_XINIT_SOURCE = xinit-$(XAPP_XINIT_VERSION).tar.xz
XAPP_XINIT_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XINIT_DEPENDENCIES = xapp_xauth xlib_libX11
XAPP_XINIT_LICENSE = MIT
XAPP_XINIT_LICENSE_FILES = COPYING
XAPP_XINIT_CONF_OPTS = MCOOKIE=/usr/bin/mcookie

$(eval $(autotools-package))
