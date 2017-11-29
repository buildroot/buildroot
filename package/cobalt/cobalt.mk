COBALT_VERSION = bc6949c0f0e8954e31f338be26b093988650b15f
COBALT_SITE = https://github.com/Metrological/cobalt
COBALT_SITE_METHOD = git
export BUILDROOT_HOME=$(HOST_DIR)/usr
export PATH := $(HOST_DIR)/bin:$(HOST_DIR)/usr/bin:$(HOST_DIR)/usr/sbin:$(PATH)

COBALT_DEPENDENCIES = alsa-lib
ifeq ($(BR2_PACKAGE_COBALT_WITH_FFMPEG),y)
export RASPI_HOME=$(HOST_DIR)/usr
COBALT_DEPENDENCIES = ffmpeg alsa-lib
endif

ifeq ($(BR2_PACKAGE_COBALT_WITH_FFMPEG),y)
define COBALT_BUILD_CMDS
	$(@D)/src/cobalt/build/gyp_cobalt -C qa raspi-2
	$(BUILDROOT_HOME)/bin/ninja -C $(@D)/src/out/raspi-2_qa cobalt
endef
define COBALT_INSTALL_TARGET_CMDS
        cp -a $(@D)/src/out/raspi-2_qa/cobalt $(TARGET_DIR)/usr/bin
        cp -a $(@D)/src/out/raspi-2_qa/content $(TARGET_DIR)/usr/share
        rm -rf $(TARGET_DIR)/usr/bin/content
        ln -s /usr/share/content $(TARGET_DIR)/usr/bin/content
endef
endif

ifeq ($(BR2_PACKAGE_COBALT_WITH_GSTREAMER),y)
define COBALT_BUILD_CMDS
	$(@D)/src/cobalt/build/gyp_cobalt -C qa wpe-rpi
	$(BUILDROOT_HOME)/bin/ninja -C $(@D)/src/out/wpe-rpi_qa cobalt
endef
define COBALT_INSTALL_TARGET_CMDS
        cp -a $(@D)/src/out/wpe-rpi_qa/cobalt $(TARGET_DIR)/usr/bin
        cp -a $(@D)/src/out/wpe-rpi_qa/content $(TARGET_DIR)/usr/share
        rm -rf $(TARGET_DIR)/usr/bin/content
        ln -s /usr/share/content $(TARGET_DIR)/usr/bin/content
endef
endif

$(eval $(generic-package))

