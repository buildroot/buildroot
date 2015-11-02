###############################################################################
#
# wpe-launcher
#
################################################################################

WPE_LAUNCHER_VERSION = 7801e6b4a43b48aff1236e3e69f5f7f1c200e5a3
WPE_LAUNCHER_SITE = $(call github,Metrological,wpe-launcher,$(WPE_LAUNCHER_VERSION))

WPE_LAUNCHER_DEPENDENCIES = wpe

define WPE_LAUNCHER_AUTOSTART
	$(INSTALL) -D -m 0755 package/wpe-launcher/wpe $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 package/wpe-launcher/S90wpe $(TARGET_DIR)/etc/init.d
	if [ -f package/wpe-launcher/wpe-update ]; then \
		$(INSTALL) -D -m 0755 package/wpe-launcher/wpe-update $(TARGET_DIR)/usr/bin; \
	fi
endef

WPE_LAUNCHER_POST_INSTALL_TARGET_HOOKS += WPE_LAUNCHER_AUTOSTART

$(eval $(cmake-package))
