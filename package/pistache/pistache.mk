################################################################################
#
# pistache
#
################################################################################

PISTACHE_VERSION = 0.4.26
PISTACHE_SITE = $(call github,pistacheio,pistache,v$(PISTACHE_VERSION))
PISTACHE_LICENSE = Apache-2.0
PISTACHE_LICENSE_FILES = LICENSE

PISTACHE_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_RAPIDJSON),y)
PISTACHE_DEPENDENCIES += rapidjson
PISTACHE_CONF_OPTS += -DPISTACHE_USE_RAPIDJSON=true
else
PISTACHE_CONF_OPTS += -DPISTACHE_USE_RAPIDJSON=false
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
PISTACHE_DEPENDENCIES += openssl
PISTACHE_CONF_OPTS += -DPISTACHE_USE_SSL=true
else
PISTACHE_CONF_OPTS += -DPISTACHE_USE_SSL=false
endif

$(eval $(meson-package))
