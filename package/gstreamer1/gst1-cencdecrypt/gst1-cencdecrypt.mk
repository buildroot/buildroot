GST1_CENCDECRYPT_VERSION = 80dd18e9f6217021b245119c615ae4cf021ac489
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
