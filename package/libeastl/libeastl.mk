################################################################################
#
# libeastl
#
################################################################################

LIBEASTL_VERSION = 3.27.01
LIBEASTL_SITE = $(call github,electronicarts,EASTL,$(LIBEASTL_VERSION))
LIBEASTL_LICENSE = BSD-3-Clause
LIBEASTL_LICENSE_FILES = LICENSE
LIBEASTL_INSTALL_STAGING = YES

$(eval $(cmake-package))
