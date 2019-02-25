################################################################################
#
# pwswd
#
################################################################################

PWSWD_VERSION = 9a82cbf
PWSWD_SITE = $(call github,pcercuei,pwswd,$(PWSWD_VERSION))
PWSWD_DEPENDENCIES = alsa-lib libpng libini

PWSWD_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" \
				 CROSS_COMPILE="$(TARGET_CROSS)" PREFIX=/usr \
				 CONFIG=$(BR2_PACKAGE_PWSWD_PLATFORM)

define PWSWD_BUILD_CMDS
	$(PWSWD_MAKE_ENV) $(MAKE) -C $(@D)
endef

define PWSWD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/pwswd $(TARGET_DIR)/usr/sbin/pwswd
	$(INSTALL) -D -m 0644 $(@D)/pwswd-$(BR2_PACKAGE_PWSWD_PLATFORM).conf $(TARGET_DIR)/etc/pwswd.conf
	$(INSTALL) -D -m 0755 board/opendingux/package/pwswd/S91pwswd.sh $(TARGET_DIR)/etc/init.d/S91pwswd.sh
endef

$(eval $(generic-package))
