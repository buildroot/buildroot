################################################################################
#
# mbw
#
################################################################################

MBW_VERSION = 1.5
MBW_SITE = $(call github,raas,mbw,v$(MBW_VERSION))
MBW_LICENSE = LGPL-2.1
MBW_LICENSE_FILES = mbw.spec

$(eval $(cmake-package))
