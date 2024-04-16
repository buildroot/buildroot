################################################################################
#
# mbw
#
################################################################################

MBW_VERSION = 2.0
MBW_SITE = $(call github,raas,mbw,v$(MBW_VERSION))
MBW_LICENSE = GPL-3.0+
MBW_LICENSE_FILES = LICENSE

$(eval $(cmake-package))
