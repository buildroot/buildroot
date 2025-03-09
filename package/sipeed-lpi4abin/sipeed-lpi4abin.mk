################################################################################
#
# sipeed-lpi4abin
#
################################################################################

SIPEED_LPI4ABIN_VERSION = 44ec4e1cc82141963842ec45db0d1617f9f07e75
SIPEED_LPI4ABIN_SITE = https://github.com/revyos/th1520-boot-firmware.git
SIPEED_LPI4ABIN_SITE_METHOD = git
SIPEED_LPI4ABIN_LICENSE = PROPRIETARY

SIPEED_LPI4ABIN_INSTALL_IMAGES = YES
SIPEED_LPI4ABIN_INSTALL_TARGET = NO

SIPEED_LPI4ABIN_FILES = \
	addons/boot/light_aon_fpga.bin \
	addons/boot/light_c906_audio.bin \
	addons/boot/str.bin

define SIPEED_LPI4ABIN_INSTALL_IMAGES_CMDS
	$(foreach f,$(SIPEED_LPI4ABIN_FILES), \
		$(INSTALL) -D -m 0644 -t $(BINARIES_DIR)/bootbins $(@D)/$(f)
	)
endef

$(eval $(generic-package))
