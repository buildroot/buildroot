################################################################################
#
# procdump-for-linux
#
################################################################################

PROCDUMP_FOR_LINUX_VERSION = 3ac1f7cd2ea0f2e433bae91b3f6fa78891cb7b04
PROCDUMP_FOR_LINUX_SITE = $(call github,microsoft,procdump-for-linux,$(PROCDUMP_FOR_LINUX_VERSION))
PROCDUMP_FOR_LINUX_LICENSE = MIT
PROCDUMP_FOR_LINUX_LICENSE_FILES = LICENSE

define PROCDUMP_FOR_LINUX_BUILD_CMDS
	$(TARGET_MAKE_ENV) make -C $(@D) CROSS_COMPILE="$(TARGET_CROSS)"
endef

define PROCDUMP_FOR_LINUX_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/bin/procdump \
		$(TARGET_DIR)/usr/bin/procdump
	$(INSTALL) -m 0755 -D $(@D)/bin/ProcDumpTestApplication \
		$(TARGET_DIR)/usr/bin/ProcDumpTestApplication

endef

$(eval $(generic-package))
