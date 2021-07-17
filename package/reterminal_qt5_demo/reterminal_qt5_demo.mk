RETERMINAL_QT5_DEMO_VERSION = main
RETERMINAL_QT5_DEMO_SITE = https://github.com/Seeed-Studio/Seeed_Python_ReTerminalQt5Examples.git
RETERMINAL_QT5_DEMO_SITE_METHOD = git
RETERMINAL_QT5_DEMO_INSTALL_STAGING = NO
RETERMINAL_QT5_DEMO_INSTALL_TARGET = YES

define RETERMINAL_QT5_DEMO_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/root/root/Seeed_Python_ReTerminalQt5Examples/
	mkdir -p $(TARGET_DIR)/root/Seeed_Python_ReTerminalQt5Examples/
	cp -rf $(@D)/* $(TARGET_DIR)/root/Seeed_Python_ReTerminalQt5Examples/
	cp -r $(@D)/fonts $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
