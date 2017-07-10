################################################################################
#
# system-plugin
#
################################################################################
SYSTEM_PLUGIN_VERSION   = 0.1
SYSTEM_PLUGIN_SITE   = $(PWD)/package/system-plugin
SYSTEM_PLUGIN_SITE_METHOD   = local
define SYSTEM_PLUGIN_INSTALL_TARGET_CMDS
$(INSTALL) -m 0755 -D package/system-plugin/etc/init.d/resize2fs $(TARGET_DIR)/etc/init.d/S35resize2fs
endef
$(eval   $(generic-package))

