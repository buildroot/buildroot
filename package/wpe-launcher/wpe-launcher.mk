###############################################################################
#
# wpe-launcher
#
################################################################################

WPE_LAUNCHER_VERSION = 8f6d5b57cc1a36ef7a01db4f3a395b6e082203f4
WPE_LAUNCHER_SITE = $(call github,Metrological,wpe-launcher,$(WPE_LAUNCHER_VERSION))

WPE_LAUNCHER_DEPENDENCIES = wpe

define WPE_LAUNCHER_BINS
	$(INSTALL) -D -m 0644 package/wpe-launcher/wpe.{txt,conf} $(BINARIES_DIR)/
	$(INSTALL) -D -m 0755 package/wpe-launcher/wpe $(TARGET_DIR)/usr/bin
	if [ -f package/wpe-launcher/wpe-update ]; then \
		$(INSTALL) -D -m 0755 package/wpe-launcher/wpe-update $(TARGET_DIR)/usr/bin; \
	fi
endef

define WPE_LAUNCHER_AUTOSTART
	$(INSTALL) -D -m 0755 package/wpe-launcher/S90wpe $(TARGET_DIR)/etc/init.d
endef

WPE_LAUNCHER_POST_INSTALL_TARGET_HOOKS += WPE_LAUNCHER_BINS

ifeq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER),)
WPE_LAUNCHER_POST_INSTALL_TARGET_HOOKS += WPE_LAUNCHER_AUTOSTART
endif

$(eval $(cmake-package))
