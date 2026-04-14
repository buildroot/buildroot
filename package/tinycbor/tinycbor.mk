################################################################################
#
# tinycbor
#
################################################################################

TINYCBOR_VERSION = 7.0
TINYCBOR_SITE = $(call github,intel,tinycbor,v$(TINYCBOR_VERSION))
TINYCBOR_LICENSE = MIT
TINYCBOR_LICENSE_FILES = LICENSE

TINYCBOR_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_CJSON),y)
TINYCBOR_DEPENDENCIES += cjson
endif

$(eval $(cmake-package))
