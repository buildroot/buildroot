################################################################################
#
# rpi3plus-bt-firmware
#
################################################################################

RPI3PLUS_BT_FIRMWARE_VERSION = fff76cb15527c435ce99a9787848eacd6288282c
RPI3PLUS_BT_FIRMWARE_SITE = https://github.com/RPi-Distro/bluez-firmware.git
RPI3PLUS_BT_FIRMWARE_SITE_METHOD = git
RPI3PLUS_BT_FIRMWARE_LICENSE = PROPRIETARY

# The BlueZ hciattach utility looks for firmware in /etc/firmware. Add a
# compatibility symlink.
define RPI3PLUS_BT_FIRMWARE_INSTALL_TARGET_CMDS
	ln -sf ../lib/firmware $(TARGET_DIR)/etc/firmware
	$(INSTALL) -D -m 0644 $(@D)/broadcom/BCM4345C0.hcd \
		$(TARGET_DIR)/lib/firmware/BCM4345C0.hcd
endef

$(eval $(generic-package))
