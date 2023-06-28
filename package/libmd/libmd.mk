################################################################################
#
# libmd
#
################################################################################

LIBMD_VERSION = 1.1.0
LIBMD_SOURCE = libmd-$(LIBMD_VERSION).tar.xz
LIBMD_SITE = https://archive.hadrons.org/software/libmd
LIBMD_LICENSE = BSD-2-Clause, BSD-3-Clause, Beerware, ISC, Public Domain
LIBMD_LICENSE_FILES = COPYING
LIBMD_INSTALL_STAGING = YES

$(eval $(autotools-package))
