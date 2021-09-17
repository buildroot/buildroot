################################################################################
#
# msgpack
#
################################################################################

MSGPACK_VERSION = 3.3.0
MSGPACK_SITE = https://github.com/msgpack/msgpack-c/releases/download/cpp-$(MSGPACK_VERSION)
MSGPACK_LICENSE = BSL-1.0
MSGPACK_LICENSE_FILES = COPYING LICENSE_1_0.txt
MSGPACK_INSTALL_STAGING = YES
MSGPACK_CONF_OPTS = -DMSGPACK_BUILD_EXAMPLES=OFF -DMSGPACK_BUILD_TESTS=OFF

ifeq ($(BR2_STATIC_LIBS),y)
MSGPACK_CONF_OPTS += -DMSGPACK_ENABLE_SHARED=OFF
endif

$(eval $(cmake-package))
