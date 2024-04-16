################################################################################
#
# xapp_bdftopcf
#
################################################################################

XAPP_BDFTOPCF_VERSION = 1.1.1
XAPP_BDFTOPCF_SOURCE = bdftopcf-$(XAPP_BDFTOPCF_VERSION).tar.xz
XAPP_BDFTOPCF_SITE = https://xorg.freedesktop.org/archive/individual/util
XAPP_BDFTOPCF_LICENSE = MIT
XAPP_BDFTOPCF_LICENSE_FILES = COPYING
XAPP_BDFTOPCF_DEPENDENCIES = xlib_libXfont
HOST_XAPP_BDFTOPCF_DEPENDENCIES = host-xlib_libXfont

# needed for linking against libXfont
XAPP_BDFTOPCF_MAKE_OPTS += LIBS=-ldl

$(eval $(autotools-package))
$(eval $(host-autotools-package))
