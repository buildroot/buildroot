################################################################################
#
# slirp4netns
#
################################################################################

SLIRP4NETNS_VERSION = 1.3.2
SLIRP4NETNS_SITE = $(call github,rootless-containers,slirp4netns,v$(SLIRP4NETNS_VERSION))
SLIRP4NETNS_LICENSE = GPL-2.0
SLIRP4NETNS_LICENSE_FILES = COPYING
SLIRP4NETNS_DEPENDENCIES = libcap libglib2 libseccomp slirp

SLIRP4NETNS_AUTORECONF = YES

define SLIRP4NETNS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_CORE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NETDEVICES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_CORE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_INET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_TUN)
endef

$(eval $(autotools-package))
