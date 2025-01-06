################################################################################
#
# lynis
#
################################################################################

LYNIS_VERSION = 3.1.3
LYNIS_SITE = $(call github,CISOfy,lynis,$(LYNIS_VERSION))
LYNIS_LICENSE = GPL-3.0
LYNIS_LICENSE_FILES = LICENSE

define LYNIS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/lynis \
		$(TARGET_DIR)/usr/sbin/lynis
	$(INSTALL) -D -m 0644 $(@D)/default.prf \
		$(TARGET_DIR)/etc/lynis/default.prf
	$(INSTALL) -D -m 0644 $(@D)/developer.prf \
		$(TARGET_DIR)/etc/lynis/developer.prf
	$(INSTALL) -D -m 0644 $(@D)/plugins/* \
		-t $(TARGET_DIR)/etc/lynis/plugins
	$(INSTALL) -D -m 0644 $(@D)/include/* \
		-t $(TARGET_DIR)/usr/share/lynis/include
	$(INSTALL) -D -m 0644 $(@D)/db/*.db \
		-t $(TARGET_DIR)/usr/share/lynis/db
	$(INSTALL) -D -m 0644 $(@D)/db/languages/en \
		$(TARGET_DIR)/usr/share/lynis/db/languages/en
endef

ifneq ($(BR2_PACKAGE_GAWK),y)
define LYNIS_AWK_BUSYBOX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_AWK)
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_AWK_LIBM)
endef
endif

ifneq ($(BR2_PACKAGE_COREUTILS),y)
define LYNIS_STAT_BUSYBOX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_STAT)
endef
endif

define LYNIS_BUSYBOX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_PGREP)
	$(LYNIS_AWK_BUSYBOX_CONFIG_FIXUPS)
	$(LYNIS_STAT_BUSYBOX_CONFIG_FIXUPS)
endef

$(eval $(generic-package))
