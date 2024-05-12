################################################################################
#
# tbtools
#
################################################################################

TBTOOLS_VERSION = 0.3.2
TBTOOLS_SITE = $(call github,intel,tbtools,v$(TBTOOLS_VERSION))
TBTOOLS_LICENSE = MIT
TBTOOLS_LICENSE_FILES = LICENSE
TBTOOLS_DEPENDENCIES = udev

$(eval $(cargo-package))
