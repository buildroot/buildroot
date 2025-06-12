################################################################################
#
# msgpack-c
#
################################################################################

MSGPACK_C_VERSION = 6.1.0
MSGPACK_C_SITE = $(call github,msgpack,msgpack-c,c-$(MSGPACK_C_VERSION))
MSGPACK_C_LICENSE = BSL-1.0
MSGPACK_C_LICENSE_FILES = COPYING LICENSE_1_0.txt
MSGPACK_C_INSTALL_STAGING = YES
MSGPACK_C_CONF_OPTS = -DMSGPACK_BUILD_EXAMPLES=OFF -DMSGPACK_BUILD_TESTS=OFF

ifeq ($(BR2_STATIC_LIBS),y)
MSGPACK_C_CONF_OPTS += -DMSGPACK_ENABLE_SHARED=OFF
endif

$(eval $(cmake-package))
