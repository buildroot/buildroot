################################################################################
#
# msgpack-c
#
################################################################################

MSGPACK_C_VERSION = 7.0.2
MSGPACK_C_SITE = https://github.com/msgpack/msgpack-c/releases/download/c-$(MSGPACK_C_VERSION)
MSGPACK_C_LICENSE = BSL-1.0
MSGPACK_C_LICENSE_FILES = COPYING LICENSE_1_0.txt
MSGPACK_C_INSTALL_STAGING = YES
MSGPACK_C_CONF_OPTS = -DMSGPACK_BUILD_EXAMPLES=OFF -DMSGPACK_BUILD_TESTS=OFF

ifeq ($(BR2_STATIC_LIBS),y)
MSGPACK_C_CONF_OPTS += -DMSGPACK_ENABLE_SHARED=OFF
endif

$(eval $(cmake-package))
