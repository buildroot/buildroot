################################################################################
#
# protozero
#
################################################################################

PROTOZERO_VERSION = 1.7.0
PROTOZERO_SITE = $(call github,mapbox,protozero,v$(PROTOZERO_VERSION))
PROTOZERO_LICENSE = BSD-2-Clause, Apache-2.0
PROTOZERO_LICENSE_FILES = LICENSE.md LICENSE.from_folly
PROTOZERO_INSTALL_STAGING = YES

$(eval $(cmake-package))
