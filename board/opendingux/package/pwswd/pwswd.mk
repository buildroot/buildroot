################################################################################
#
# pwswd
#
################################################################################

PWSWD_VERSION = 67d8d65
PWSWD_SITE = $(call github,pcercuei,pwswd,$(PWSWD_VERSION))
PWSWD_DEPENDENCIES = alsa-lib libini

PWSWD_CONF_OPTS += -DBACKENDS=$(BR2_PACKAGE_PWSWD_BACKENDS)

define PWSWD_INSTALL_INIT_FILE
	$(INSTALL) -D -m 0755 board/opendingux/package/pwswd/S91pwswd.sh $(TARGET_DIR)/etc/init.d/S91pwswd.sh
endef
PWSWD_POST_INSTALL_TARGET_HOOKS += PWSWD_INSTALL_INIT_FILE

$(eval $(cmake-package))
