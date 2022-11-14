################################################################################
#
# safeclib
#
################################################################################

SAFECLIB_VERSION = 3.7.1
SAFECLIB_SITE = \
	https://github.com/rurban/safeclib/releases/download/v$(SAFECLIB_VERSION)
SAFECLIB_SOURCE = safeclib-$(SAFECLIB_VERSION).tar.xz
SAFECLIB_LICENSE = MIT
SAFECLIB_LICENSE_FILES = COPYING
SAFECLIB_INSTALL_STAGING = YES
SAFECLIB_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -std=c99"
# -fstack-protector-strong is used by default. Disable that so the
# BR2_SSP_* options in the toolchain wrapper are used instead
SAFECLIB_CONF_OPTS = --disable-hardening

$(eval $(autotools-package))
