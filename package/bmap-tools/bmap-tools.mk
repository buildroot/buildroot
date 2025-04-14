################################################################################
#
# bmap-tools
#
################################################################################

BMAP_TOOLS_VERSION = 3.9.0
BMAP_TOOLS_SITE = $(call github,yoctoproject,bmaptool,v$(BMAP_TOOLS_VERSION))
BMAP_TOOLS_LICENSE = GPL-2.0
BMAP_TOOLS_LICENSE_FILES = LICENSE
BMAP_TOOLS_SETUP_TYPE = hatch

$(eval $(python-package))
$(eval $(host-python-package))
