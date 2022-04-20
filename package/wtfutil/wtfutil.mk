################################################################################
#
# wtfutil
#
################################################################################

WTFUTIL_VERSION = 0.41.0
WTFUTIL_SITE = $(call github,wtfutil,wtf,v$(WTFUTIL_VERSION))
WTFUTIL_LICENSE = MPL-2.0
WTFUTIL_LICENSE_FILES = LICENSE.md

$(eval $(golang-package))
