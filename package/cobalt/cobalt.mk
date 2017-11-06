COBALT_VERSION = ef837fa448402e2ada2fb3821210cc20d850164b
COBALT_SITE = https://cobalt.googlesource.com/cobalt
COBALT_SITE_METHOD = git
export RASPI_HOME=$(HOST_DIR)/usr
export PATH := $(HOST_DIR)/bin:$(HOST_DIR)/usr/bin:$(HOST_DIR)/usr/sbin:$(PATH)

COBALT_DEPENDENCIES = ffmpeg alsa-lib

define COBALT_CONFIGURE_CMDS
        git clone https://cobalt.googlesource.com/depot_tools $(@D)/depot_tools
endef

define COBALT_BUILD_CMDS
        $(@D)/src/cobalt/build/gyp_cobalt -C qa raspi-2
        $(RASPI_HOME)/bin/ninja -C $(@D)/src/out/raspi-2_qa cobalt
endef

define COBALT_INSTALL_TARGET_CMDS
        cp -a $(@D)/src/out/raspi-2_qa/cobalt $(TARGET_DIR)/usr/bin
        cp -a $(@D)/src/out/raspi-2_qa/content $(TARGET_DIR)/usr/share
        rm -rf $(TARGET_DIR)/usr/bin/content
        ln -s /usr/share/content $(TARGET_DIR)/usr/bin/content
endef

$(eval $(generic-package))

