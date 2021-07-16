RETERMINAL_QT5_DEMO_VERSION = 7986128237c1bdb5d8a77db21ac3c3e4486f2947
RETERMINAL_QT5_DEMO_SITE = https://github.com/Seeed-Studio/Seeed_Python_ReTerminalQt5Examples.git
RETERMINAL_QT5_DEMO_SITE_METHOD = git
RETERMINAL_QT5_DEMO_INSTALL_STAGING = NO
RETERMINAL_QT5_DEMO_INSTALL_TARGET = YES

define RETERMINAL_QT5_DEMO_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/root/Seeed_Python_ReTerminalQt5Examples/
	cp -rf $(@D)/* $(TARGET_DIR)/root/Seeed_Python_ReTerminalQt5Examples/
	cp -r $(@D)/fonts $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
