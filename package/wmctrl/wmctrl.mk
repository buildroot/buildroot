################################################################################
#
# wmctrl
#
################################################################################

WMCTRL_VERSION = 1.07
WMCTRL_SOURCE = wmctrl_$(WMCTRL_VERSION).orig.tar.gz
WMCTRL_SITE = https://snapshot.debian.org/archive/debian/20050312T000000Z/pool/main/w/wmctrl
WMCTRL_LICENSE = GPL-2.0+
WMCTRL_LICENSE_FILES = COPYING

WMCTRL_DEPENDENCIES = libglib2 xlib_libX11 xlib_libXmu

WMCTRL_CONF_OPTS = \
	--x-includes=$(STAGING_DIR)/usr/include \
	--x-libraries=$(STAGING_DIR)/usr/lib

$(eval $(autotools-package))
