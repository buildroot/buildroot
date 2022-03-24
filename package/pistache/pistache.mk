################################################################################
#
# pistache
#
################################################################################

PISTACHE_VERSION = 3ec9d7c4f8b828fdd391550fff81b01e72dd6269
PISTACHE_SITE = $(call github,oktal,pistache,$(PISTACHE_VERSION))
PISTACHE_LICENSE = Apache-2.0
PISTACHE_LICENSE_FILES = LICENSE

PISTACHE_INSTALL_STAGING = YES
PISTACHE_DEPENDENCIES += rapidjson

ifeq ($(BR2_PACKAGE_OPENSSL),y)
PISTACHE_DEPENDENCIES += openssl
PISTACHE_CONF_OPTS += -DPISTACHE_USE_SSL=true
PISTACHE_CONF_OPTS += -DPISTACHE_ENABLE_NETWORK_TESTS=false
else
PISTACHE_CONF_OPTS += -DPISTACHE_USE_SSL=false
endif

$(eval $(meson-package))
