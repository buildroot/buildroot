################################################################################
#
# xtables-addons
#
################################################################################

XTABLES_ADDONS_VERSION = 3.22
XTABLES_ADDONS_SOURCE = xtables-addons-$(XTABLES_ADDONS_VERSION).tar.xz
XTABLES_ADDONS_SITE = https://inai.de/files/xtables-addons
XTABLES_ADDONS_DEPENDENCIES = iptables linux host-pkgconf
XTABLES_ADDONS_LICENSE = GPL-2.0+
XTABLES_ADDONS_LICENSE_FILES = LICENSE

XTABLES_ADDONS_CONF_OPTS = \
	--with-kbuild="$(LINUX_DIR)" \
	--with-xtables="$(STAGING_DIR)/usr" \
	--with-xtlibdir="/usr/lib/xtables"

define XTABLES_ADDONS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS)
endef

define XTABLES_ADDONS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) DESTDIR="$(TARGET_DIR)" install
endef

# geoip helpers need perl with modules and unzip so remove them
define XTABLES_ADDONS_REMOVE_GEOIP_HELPERS
	$(RM) $(TARGET_DIR)/usr/bin/xt_geoip*
	$(RM) $(TARGET_DIR)/usr/libexec/xtables-addons/xt_asn*
	$(RM) $(TARGET_DIR)/usr/libexec/xtables-addons/xt_geoip*
endef

XTABLES_ADDONS_POST_INSTALL_TARGET_HOOKS += XTABLES_ADDONS_REMOVE_GEOIP_HELPERS

define XTABLES_ADDONS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NETFILTER_ADVANCED)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NF_CONNTRACK)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NF_CONNTRACK_MARK)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NF_NAT)
endef

$(eval $(autotools-package))
