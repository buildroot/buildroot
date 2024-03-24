################################################################################
#
# redis-plus-plus
#
################################################################################

REDIS_PLUS_PLUS_VERSION = 1.3.12
REDIS_PLUS_PLUS_SITE = $(call github,sewenew,redis-plus-plus,$(REDIS_PLUS_PLUS_VERSION))
REDIS_PLUS_PLUS_LICENSE = Apache-2.0
REDIS_PLUS_PLUS_LICENSE_FILES = LICENSE
REDIS_PLUS_PLUS_INSTALL_STAGING = YES
REDIS_PLUS_PLUS_DEPENDENCIES = hiredis

REDIS_PLUS_PLUS_CONF_OPTS = \
	-DREDIS_PLUS_PLUS_BUILD_SHARED=$(if $(BR2_STATIC_LIBS),OFF,ON) \
	-DREDIS_PLUS_PLUS_BUILD_TEST=OFF

# since version 1.3.0, by default, redis-plus-plus is built with the
# -std=c++17 standard
ifeq ($(BR2_TOOLCHAIN_GCC_AT_LEAST_8),)
ifeq ($(BR2_TOOLCHAIN_GCC_AT_LEAST_5),y)
REDIS_PLUS_PLUS_CONF_OPTS += -DREDIS_PLUS_PLUS_CXX_STANDARD=14
else
REDIS_PLUS_PLUS_CONF_OPTS += -DREDIS_PLUS_PLUS_CXX_STANDARD=11
endif
endif

$(eval $(cmake-package))
