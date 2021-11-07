################################################################################
#
# libteam
#
################################################################################

LIBTEAM_VERSION = 1.31
LIBTEAM_SITE = $(call github,jpirko,libteam,v$(LIBTEAM_VERSION))
LIBTEAM_LICENSE = LGPL-2.1+
LIBTEAM_LICENSE_FILES = COPYING
LIBTEAM_DEPENDENCIES = host-pkgconf jansson libdaemon libnl
LIBTEAM_AUTORECONF = YES
LIBTEAM_INSTALL_STAGING = YES

# Note: this enables basic team support, use a custom kernel config, or
#       fragment, to enable team modes, e.g. activebackup or loadbalance
define LIBTEAM_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NETDEVICES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_CORE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_TEAM)
endef

$(eval $(autotools-package))
