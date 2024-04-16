################################################################################
#
# nodejs
#
################################################################################

# _VERSION, _SOURCE and _SITE must be kept empty to avoid downloading anything
NODEJS_COMMON_VERSION = 20.11.1
NODEJS_COMMON_SOURCE = node-v$(NODEJS_COMMON_VERSION).tar.xz
NODEJS_COMMON_SITE = http://nodejs.org/dist/v$(NODEJS_COMMON_VERSION)

NODEJS_LICENSE = MIT (core code); MIT, Apache and BSD family licenses (Bundled components)
NODEJS_LICENSE_FILES = LICENSE
NODEJS_CPE_ID_VENDOR = nodejs
NODEJS_CPE_ID_PRODUCT = node.js

NODEJS_BIN_ENV = $(TARGET_CONFIGURE_OPTS) \
	LDFLAGS="$(NODEJS_LDFLAGS)" \
	LD="$(TARGET_CXX)" \
	npm_config_arch=$(NODEJS_CPU) \
	npm_config_target_arch=$(NODEJS_CPU) \
	npm_config_build_from_source=true \
	npm_config_nodedir=$(STAGING_DIR)/usr \
	npm_config_prefix=$(TARGET_DIR)/usr \
	npm_config_cache=$(BUILD_DIR)/.npm-cache

# Define various packaging tools for other packages to use
NPM = $(NODEJS_BIN_ENV) $(HOST_DIR)/bin/npm
ifeq ($(BR2_PACKAGE_HOST_NODEJS_COREPACK),y)
COREPACK = $(NODEJS_BIN_ENV) $(HOST_DIR)/bin/corepack
PNPM = $(NODEJS_BIN_ENV) $(HOST_DIR)/bin/pnpm
YARN = $(NODEJS_BIN_ENV) $(HOST_DIR)/bin/yarn
endif

NODEJS_DEPENDENCIES = nodejs-src
$(eval $(generic-package))
$(eval $(host-virtual-package))

include $(sort $(wildcard package/nodejs/*/*.mk))
