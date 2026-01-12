################################################################################
#
# xapp_xkbcomp
#
################################################################################

XAPP_XKBCOMP_VERSION = 1.5.0
XAPP_XKBCOMP_SOURCE = xkbcomp-$(XAPP_XKBCOMP_VERSION).tar.xz
XAPP_XKBCOMP_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XKBCOMP_LICENSE = MIT
XAPP_XKBCOMP_LICENSE_FILES = COPYING
XAPP_XKBCOMP_DEPENDENCIES = xlib_libX11 xlib_libxkbfile
HOST_XAPP_XKBCOMP_DEPENDENCIES = host-xlib_libX11 host-xlib_libxkbfile
XAPP_XKBCOMP_CONF_ENV = ac_cv_file___xkbparse_c=yes

$(eval $(autotools-package))
$(eval $(host-autotools-package))
