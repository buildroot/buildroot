################################################################################
#
# vis-network
#
################################################################################

VIS_NETWORK_VERSION = 9.1.0
VIS_NETWORK_SOURCE = vis-network-$(VIS_NETWORK_VERSION).tgz
VIS_NETWORK_SITE = https://registry.npmjs.org/vis-network/-
VIS_NETWORK_LICENSE = Apache-2.0 or MIT
VIS_NETWORK_LICENSE_FILES = LICENSE-APACHE-2.0 LICENSE-MIT

# Install .min.js and .min.css as .js and .css, respectively.
define VIS_NETWORK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 644 -D $(@D)/dist/vis-network.min.js \
		$(TARGET_DIR)/var/www/vis-network.js
	$(INSTALL) -m 644 -D $(@D)/dist/dist/vis-network.min.css \
		$(TARGET_DIR)/var/www/vis-network.css
endef

$(eval $(generic-package))
