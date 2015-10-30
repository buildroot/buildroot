###############################################################################
#
# wpe-launcher
#
################################################################################

WPE_LAUNCHER_VERSION = c35d3ea67804341d41b0ad3d73425172dde9ba77
WPE_LAUNCHER_SITE = $(call github,Metrological,wpe-launcher,$(WPE_LAUNCHER_VERSION))

WPE_LAUNCHER_DEPENDENCIES = wpe

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
WPE_LAUNCHER_CONF_OPTS = \
	-DCMAKE_C_FLAGS="-DTARGET_RPI=1" \
	-DCMAKE_CXX_FLAGS="-DTARGET_RPI=1"
endif

define WPE_LAUNCHER_AUTOSTART
	$(INSTALL) -D -m 0755 package/wpe-launcher/wpe $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 package/wpe-launcher/S90wpe $(TARGET_DIR)/etc/init.d
	if [ -f package/wpe-launcher/wpe-update ]; then \
		$(INSTALL) -D -m 0755 package/wpe-launcher/wpe-update $(TARGET_DIR)/usr/bin; \
	fi
endef

WPE_LAUNCHER_POST_INSTALL_TARGET_HOOKS += WPE_LAUNCHER_AUTOSTART

$(eval $(cmake-package))
