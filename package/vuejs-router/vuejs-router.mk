################################################################################
#
# vuejs-router
#
################################################################################

VUEJS_ROUTER_VERSION = 4.4.5
VUEJS_ROUTER_SOURCE = vue-router-$(VUEJS_ROUTER_VERSION).tgz
VUEJS_ROUTER_SITE = https://registry.npmjs.org/vue-router/-
VUEJS_ROUTER_LICENSE = MIT
VUEJS_ROUTER_LICENSE_FILES = LICENSE

# Install .prod.js as .js
define VUEJS_ROUTER_INSTALL_TARGET_CMDS
	$(INSTALL) -m 644 -D $(@D)/dist/vue-router.global.prod.js \
		$(TARGET_DIR)/var/www/vue-router.js
endef

$(eval $(generic-package))
