################################################################################
#
# quazip
#
################################################################################

QUAZIP_VERSION = 1.4
QUAZIP_SITE = $(call github,stachenov,quazip,v$(QUAZIP_VERSION))
QUAZIP_INSTALL_STAGING = YES
QUAZIP_DEPENDENCIES = zlib

ifeq ($(BR2_PACKAGE_QT5BASE),y)
QUAZIP_DEPENDENCIES +=  qt5base
endif
ifeq ($(BR2_PACKAGE_QT6BASE),y)
QUAZIP_DEPENDENCIES +=  qt6base qt6core5compat
endif

QUAZIP_LICENSE = LGPL-2.1
QUAZIP_LICENSE_FILES = COPYING
QUAZIP_CPE_ID_VALID = YES

$(eval $(cmake-package))
