################################################################################
#
# safeclib
#
################################################################################

SAFECLIB_VERSION = 02092020
SAFECLIB_SITE = \
	https://github.com/rurban/safeclib/releases/download/v$(SAFECLIB_VERSION)
SAFECLIB_SOURCE = libsafec-$(SAFECLIB_VERSION).tar.xz
SAFECLIB_LICENSE = MIT
SAFECLIB_LICENSE_FILES = COPYING
SAFECLIB_INSTALL_STAGING = YES

$(eval $(autotools-package))
