################################################################################
#
# forge
#
################################################################################

FORGE_VERSION = 1.3.1
FORGE_SITE = https://registry.npmjs.org/node-forge/-
FORGE_SOURCE = node-forge-$(FORGE_VERSION).tgz
FORGE_LICENSE = BSD-3-Clause, GPL-2.0, vendored dependencies licenses probably not listed
FORGE_LICENSE_FILES = LICENSE
FORGE_CPE_ID_VENDOR = digitalbazaar

# Install .min.js as .js
define FORGE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 644 -D $(@D)/dist/forge.all.min.js \
		$(TARGET_DIR)/var/www/forge.all.js
	$(INSTALL) -m 644 -D $(@D)/dist/forge.min.js \
		$(TARGET_DIR)/var/www/forge.js
	$(INSTALL) -m 644 -D $(@D)/dist/prime.worker.min.js \
		$(TARGET_DIR)/var/www/prime.worker.js
endef

$(eval $(generic-package))
