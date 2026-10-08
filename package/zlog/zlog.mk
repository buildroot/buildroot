################################################################################
#
# zlog
#
################################################################################

ZLOG_VERSION = 1.2.20
ZLOG_SITE = $(call github,HardySimpson,zlog,$(ZLOG_VERSION))
ZLOG_LICENSE = Apache-2.0
ZLOG_LICENSE_FILES = LICENSE
ZLOG_CPE_ID_VALID = YES
ZLOG_INSTALL_STAGING = YES

# CMakeLists.txt refuses an in source build, as it would overwrite the hand
# written makefiles that are part of the source tree
ZLOG_SUPPORTS_IN_SOURCE_BUILD = NO

ZLOG_CONF_OPTS = -DZLOG_WERROR=OFF

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
ZLOG_CONF_OPTS += -DCMAKE_SHARED_LINKER_FLAGS=-latomic
endif

$(eval $(cmake-package))
