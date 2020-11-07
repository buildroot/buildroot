################################################################################
#
# slirp
#
################################################################################

SLIRP_VERSION = 4.3.1
SLIRP_SOURCE = libslirp-v$(SLIRP_VERSION).tar.bz2
SLIRP_SITE = \
	https://gitlab.freedesktop.org/slirp/libslirp/-/archive/v$(SLIRP_VERSION)
SLIRP_LICENSE = BSD-3-Clause
SLIRP_LICENSE_FILES = COPYRIGHT
SLIRP_INSTALL_STAGING = YES

$(eval $(meson-package))
