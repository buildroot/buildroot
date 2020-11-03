#############################################################
#
# od-passwd-config
#
#############################################################

OD_PASSWD_CONFIG_SITE = board/opendingux/package/od-passwd-config
OD_PASSWD_CONFIG_SITE_METHOD = local
OD_PASSWD_CONFIG_SETUP_TYPE = distutils

OD_PASSWD_CONFIG_DEPENDENCIES = host-python-cython python-pygame

ifeq ($(BR2_PACKAGE_GMENU2X),y)
OD_PASSWD_CONFIG_DEPENDENCIES += gmenu2x
define OD_PASSWD_CONFIG_INSTALL_TARGET_GMENU2X
	$(INSTALL) -m 0644 -D $(@D)/gmenu2x $(TARGET_DIR)/usr/share/gmenu2x/sections/settings/60_passwd
	$(INSTALL) -m 0644 -D $(@D)/icon.png $(TARGET_DIR)/usr/share/gmenu2x/skins/320x240/Default/icons/passwd.png
endef
OD_PASSWD_CONFIG_POST_INSTALL_TARGET_HOOKS += OD_PASSWD_CONFIG_INSTALL_TARGET_GMENU2X
endif

define OD_PASSWD_CONFIG_INSTALL_SCRIPT
	$(INSTALL) -m 0755 -D $(@D)/od-passwd-config $(TARGET_DIR)/usr/sbin/od-passwd-config
endef
OD_PASSWD_CONFIG_POST_INSTALL_TARGET_HOOKS += OD_PASSWD_CONFIG_INSTALL_SCRIPT

$(eval $(python-package))
