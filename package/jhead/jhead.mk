################################################################################
#
# jhead
#
################################################################################

JHEAD_VERSION = 3.06.0.1
JHEAD_SITE = $(call github,Matthias-Wandel,jhead,$(JHEAD_VERSION))
JHEAD_LICENSE = Public Domain
JHEAD_LICENSE_FILES = readme.txt
JHEAD_CPE_ID_VENDOR = jhead_project

define JHEAD_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define JHEAD_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/jhead $(TARGET_DIR)/usr/bin/jhead
endef

$(eval $(generic-package))
