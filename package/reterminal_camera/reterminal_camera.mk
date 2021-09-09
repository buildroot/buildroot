RETERMINAL_CAMERA_VERSION = main
RETERMINAL_CAMERA_SITE = https://github.com/bigbearishappy/v4l2_test.git
RETERMINAL_CAMERA_SITE_METHOD = git
RETERMINAL_CAMERA_INSTALL_STAGING = NO
RETERMINAL_CAMERA_INSTALL_TARGET = YES

define RETERMINAL_CAMERA_BUILD_CMDS
        $(MAKE) ARCH="$(KERNEL_ARCH)" \
                CC="$(TARGET_CC)" \
                CROSS_COMPILE="$(TARGET_CROSS)" \
                -C $(@D)
endef

define RETERMINAL_CAMERA_INSTALL_TARGET_CMDS
	wget https://datasheets.raspberrypi.org/cmio/dt-blob-disp1-cam2.bin -O $(@D)/dt-blob.bin
	$(INSTALL) -D -m 0755 $(@D)/dt-blob.bin $(BINARIES_DIR)/rpi-firmware/
	$(INSTALL) -D -m 0755 $(@D)/v4l2test $(TARGET_DIR)/usr/bin/v4l2test
endef

$(eval $(generic-package))
