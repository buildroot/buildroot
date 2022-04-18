################################################################################
#
# sun20i-d1-spl
#
################################################################################

# Commit on the 'mainline' branch
SUN20I_D1_SPL_VERSION = 4da9c518c124d6f6123bf274e449514863df3646
SUN20I_D1_SPL_SITE = $(call github,smaeul,sun20i_d1_spl,$(SUN20I_D1_SPL_VERSION))
SUN20I_D1_SPL_INSTALL_TARGET = NO
SUN20I_D1_SPL_INSTALL_IMAGES = YES
SUN20I_D1_SPL_LICENSE = GPL-2.0+

define SUN20I_D1_SPL_BUILD_CMDS
	$(MAKE) -C $(@D) CROSS_COMPILE="$(TARGET_CROSS)" p=sun20iw1p1 mmc
endef

define SUN20I_D1_SPL_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/nboot/boot0_sdcard_sun20iw1p1.bin \
		$(BINARIES_DIR)/boot0_sdcard_sun20iw1p1.bin
endef

$(eval $(generic-package))
