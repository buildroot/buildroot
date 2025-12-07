################################################################################
#
# msgpack
#
################################################################################

MSGPACK_VERSION = 7.0.0
MSGPACK_SITE = https://github.com/msgpack/msgpack-c/releases/download/cpp-$(MSGPACK_VERSION)
MSGPACK_SOURCE = msgpack-cxx-$(MSGPACK_VERSION).tar.gz
MSGPACK_LICENSE = BSL-1.0
MSGPACK_LICENSE_FILES = COPYING LICENSE_1_0.txt
MSGPACK_INSTALL_STAGING = YES
MSGPACK_CONF_OPTS = -DMSGPACK_BUILD_EXAMPLES=OFF -DMSGPACK_BUILD_TESTS=OFF

ifeq ($(BR2_STATIC_LIBS),y)
MSGPACK_CONF_OPTS += -DMSGPACK_ENABLE_SHARED=OFF
endif

ifeq ($(BR2_PACKAGE_BOOST),y)
MSGPACK_CONF_OPTS += -DMSGPACK_USE_BOOST=ON
MSGPACK_DEPENDENCIES += boost
else
MSGPACK_CONF_OPTS += -DMSGPACK_USE_BOOST=OFF
endif

$(eval $(cmake-package))
