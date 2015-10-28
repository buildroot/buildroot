###############################################################################
#
# wpe-launcher
#
################################################################################

WPE_LAUNCHER_VERSION = 8d74174af07627f334c29e5effdcd58b06de110d
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
