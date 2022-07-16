################################################################################
#
# abootimg
#
################################################################################

ABOOTIMG_VERSION = 1ebeb393252ab5aeed62e34bc439b6728444f06e
ABOOTIMG_SITE = https://gitlab.com/ajs124/abootimg.git
ABOOTIMG_SITE_METHOD = git
ABOOTIMG_LICENSE = GPL-2.0+
ABOOTIMG_LICENSE_FILES = LICENSE

# depends on libblkid from util-linux
ABOOTIMG_DEPENDENCIES = util-linux
HOST_ABOOTIMG_DEPENDENCIES = host-util-linux

define ABOOTIMG_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define ABOOTIMG_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/abootimg $(TARGET_DIR)/usr/bin/abootimg
endef

define HOST_ABOOTIMG_BUILD_CMDS
	$(MAKE) $(HOST_CONFIGURE_OPTS) -C $(@D)
endef

define HOST_ABOOTIMG_INSTALL_CMDS
	$(INSTALL) -m 0755 $(@D)/abootimg $(HOST_DIR)/bin/abootimg
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
