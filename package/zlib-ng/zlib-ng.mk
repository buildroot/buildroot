################################################################################
#
# zlib-ng
#
################################################################################

ZLIB_NG_VERSION = 9609cb56a8f62868ccf264493bc9c3b4d5762fcf
ZLIB_NG_SITE = $(call github,zlib-ng,zlib-ng,$(ZLIB_NG_VERSION))
ZLIB_NG_LICENSE = Zlib
ZLIB_NG_LICENSE_FILES = LICENSE.md
ZLIB_NG_INSTALL_STAGING = YES
ZLIB_NG_PROVIDES = zlib

# Build with zlib compatible API, gzFile support and optimizations on
ZLIB_NG_CONF_OPTS += -DZLIB_COMPAT=1 -DWITH_GZFILEOP=1 -DWITH_OPTIM=1 -DCC=$(TARGET_CC)

# Enable NEON and ACLE on ARM
ifeq ($(BR2_arm),y)
ZLIB_NG_CONF_OPTS += -DWITH_ACLE=1 -DWITH_NEON=1
endif

$(eval $(cmake-package))
