################################################################################
#
# catch2
#
################################################################################

CATCH2_VERSION = 3.5.2
CATCH2_SITE = $(call github,catchorg,Catch2,v$(CATCH2_VERSION))
CATCH2_INSTALL_STAGING = YES
CATCH2_INSTALL_TARGET = NO
CATCH2_LICENSE = BSL-1.0
CATCH2_LICENSE_FILES = LICENSE.txt
CATCH2_SUPPORTS_IN_SOURCE_BUILD = NO

# We force building a static library only as building a dynamic
# library is not really supported officially:
# https://github.com/catchorg/Catch2/blob/devel/docs/faq.md#can-i-compile-catch2-into-a-dynamic-library
CATCH2_CONF_OPTS = \
	-DCATCH_INSTALL_DOCS=OFF \
	-DBUILD_SHARED_LIBS=OFF

$(eval $(cmake-package))
