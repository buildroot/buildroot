################################################################################
#
# bmap-tools
#
################################################################################

BMAP_TOOLS_VERSION = 3.6
BMAP_TOOLS_SITE = $(call github,intel,bmap-tools,v$(BMAP_TOOLS_VERSION))
BMAP_TOOLS_LICENSE = GPL-2.0
BMAP_TOOLS_LICENSE_FILES = COPYING
BMAP_TOOLS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
