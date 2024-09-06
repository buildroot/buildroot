################################################################################
#
# slirp
#
################################################################################

SLIRP_VERSION = 4.8.0
SLIRP_SOURCE = libslirp-v$(SLIRP_VERSION).tar.bz2
SLIRP_SITE = https://gitlab.freedesktop.org/slirp/libslirp/-/archive/v$(SLIRP_VERSION)
SLIRP_LICENSE = BSD-3-Clause
SLIRP_LICENSE_FILES = COPYRIGHT
SLIRP_CPE_ID_VENDOR = libslirp_project
SLIRP_CPE_ID_PRODUCT = libslirp
SLIRP_INSTALL_STAGING = YES
SLIRP_DEPENDENCIES = libglib2

HOST_SLIRP_DEPENDENCIES = host-libglib2

$(eval $(meson-package))
$(eval $(host-meson-package))
