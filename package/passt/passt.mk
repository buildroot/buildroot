################################################################################
#
# passt
#
################################################################################

PASST_VERSION = 2025_02_17.a1e48a0
PASST_SITE = https://passt.top/passt
PASST_SITE_METHOD = git

PASST_LICENSE = \
	BSD-3-Clause, \
	GPL-2.0-or-later
PASST_LICENSE_FILES = \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/GPL-2.0-or-later.txt

define PASST_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_CORE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NETDEVICES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_CORE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_INET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_TUN)
endef

define PASST_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) \
		-C $(@D) \
		prefix=/usr
endef

define PASST_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) \
		-C $(@D) \
		prefix=/usr \
		DESTDIR=$(TARGET_DIR) \
		install
endef

$(eval $(generic-package))
