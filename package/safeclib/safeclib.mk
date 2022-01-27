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
# We're patching configure.ac
SAFECLIB_AUTORECONF = YES
# -fstack-protector-strong is used by default. Disable that so the
# BR2_SSP_* options in the toolchain wrapper are used instead
SAFECLIB_CONF_OPTS = --disable-hardening

$(eval $(autotools-package))
