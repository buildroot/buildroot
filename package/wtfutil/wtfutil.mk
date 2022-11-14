################################################################################
#
# wtfutil
#
################################################################################

WTFUTIL_VERSION = 0.41.0
WTFUTIL_SITE = $(call github,wtfutil,wtf,v$(WTFUTIL_VERSION))
WTFUTIL_LICENSE = MPL-2.0
WTFUTIL_LICENSE_FILES = LICENSE.md
WTFUTIL_CPE_ID_VENDOR = wtfutil
WTFUTIL_CPE_ID_PRODUCT = wtf

$(eval $(golang-package))
