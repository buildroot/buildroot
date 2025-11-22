################################################################################
#
# libmbus
#
################################################################################

LIBMBUS_VERSION = 0.9.0
LIBMBUS_SITE = $(call github,rscada,libmbus,$(LIBMBUS_VERSION))
LIBMBUS_INSTALL_STAGING = YES
LIBMBUS_LICENSE = BSD-3-Clause
LIBMBUS_LICENSE_FILES = COPYING
# github tarball does not include configure
LIBMBUS_AUTORECONF = YES
# Autoreconf is missing some directories
define LIBMBUS_CREATE_DIRS
	mkdir -p $(@D)/libltdl
	mkdir -p $(@D)/m4
endef
LIBMBUS_POST_PATCH_HOOKS += LIBMBUS_CREATE_DIRS

$(eval $(autotools-package))
