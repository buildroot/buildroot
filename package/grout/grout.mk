################################################################################
#
# grout
#
################################################################################

GROUT_VERSION = 0.11.0
GROUT_SITE = $(call github,DPDK,grout,v$(GROUT_VERSION))
GROUT_LICENSE = BSD-3-Clause
GROUT_LICENSE_FILES = licenses/BSD-3-clause.txt

# Avoid using buildroot commit hash
GROUT_CONF_ENV = GROUT_VERSION=$(GROUT_VERSION)

GROUT_DEPENDENCIES = \
	host-pkgconf \
	dpdk \
	libevent \
	numactl \
	libecoli \
	util-linux

define GROUT_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_TUN)
endef

$(eval $(meson-package))
