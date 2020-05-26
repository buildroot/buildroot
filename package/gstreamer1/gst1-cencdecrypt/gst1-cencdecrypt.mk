GST1_CENCDECRYPT_VERSION = 1456e32bc4377ffeaa99ad0652fc9eaff2524f9c
GST1_CENCDECRYPT_SITE = git@github.com:WebPlatformForEmbedded/gstcencdecryptor.git
GST1_CENCDECRYPT_SITE_METHOD = git
GST1_CENCDECRYPT_INSTALL_STAGING = YES
GST1_CENCDECRYPT_DEPENDENCIES = gstreamer1 wpeframework

define GST1_CENCDECRYPT_INSTALL_STAGING_CMDS
	$(INSTALL) $(@D)/libgstcencdecrypt.so $(STAGING_DIR)/usr/lib/libgstcencdecrypt.so
endef

define GST1_CENCDECRYPT_INSTALL_TARGET_CMDS
	$(INSTALL) $(@D)/libgstcencdecrypt.so $(TARGET_DIR)/usr/lib/libgstcencdecrypt.so
	ln -sf ../libgstcencdecrypt.so $(TARGET_DIR)/usr/lib/gstreamer-1.0/libgstcencdecrypt.so
endef

$(eval $(cmake-package))
