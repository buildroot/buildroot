################################################################################
#
# farmhash
#
################################################################################

FARMHASH_VERSION = 0d859a811870d10f53a594927d0d0b97573ad06d
FARMHASH_SITE = $(call github,google,farmhash,$(FARMHASH_VERSION))
FARMHASH_LICENSE = MIT
FARMHASH_LICENSE_FILES = COPYING
FARMHASH_INSTALL_STAGING = YES
FARMHASH_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) -std=c++11"

$(eval $(autotools-package))
