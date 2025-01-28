################################################################################
#
# fft2d
#
################################################################################

FFT2D_VERSION = 2006.12.28
FFT2D_SITE = https://www.kurims.kyoto-u.ac.jp/~ooura
FFT2D_SOURCE = fft2d.tgz
FFT2D_LICENSE = MIT-like
FFT2D_LICENSE_FILES = readme2d.txt
FFT2D_INSTALL_STAGING = YES
# Only installs headers/sources
FFT2D_INSTALL_TARGET = NO

define FFT2D_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/fft2d
	$(INSTALL) -m 0644 $(@D)/*.c $(STAGING_DIR)/usr/include/fft2d
	$(INSTALL) -m 0644 $(@D)/*.f $(STAGING_DIR)/usr/include/fft2d
	$(INSTALL) -m 0644 $(@D)/*.h $(STAGING_DIR)/usr/include/fft2d
endef

$(eval $(generic-package))
