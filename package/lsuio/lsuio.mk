################################################################################
#
# lsuio
#
################################################################################

# no tag yet
LSUIO_VERSION = ba46808da148552462e50ba66d8d15cc5b9a3a00
LSUIO_SITE = $(call github,DigitalBrains1,lsuio,$(LSUIO_VERSION))
LSUIO_LICENSE = GPL-2.0
LSUIO_LICENSE_FILES = COPYING

$(eval $(autotools-package))
