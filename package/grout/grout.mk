################################################################################
#
# grout
#
################################################################################

GROUT_VERSION = 0.14.3
GROUT_SITE = $(call github,DPDK,grout,v$(GROUT_VERSION))
GROUT_LICENSE = BSD-3-Clause
GROUT_LICENSE_FILES = licenses/BSD-3-clause.txt

# Avoid using buildroot commit hash
GROUT_CONF_ENV = GROUT_VERSION=$(GROUT_VERSION)

GROUT_DEPENDENCIES = \
	host-pkgconf \
	dpdk \
	libevent \
	libmnl \
	numactl \
	libecoli \
	util-linux

define GROUT_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_TUN)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_L3_MASTER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_VRF)
endef

$(eval $(meson-package))
