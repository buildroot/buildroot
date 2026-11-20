################################################################################
#
# grout
#
################################################################################

GROUT_VERSION = 0.20.1
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
	libpcap \
	numactl \
	libecoli

define GROUT_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_TUN)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_L3_MASTER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_VRF)
endef

ifeq ($(BR2_PACKAGE_GROUT_GRTCPDUMP),y)
GROUT_CONF_OPTS += -Dgrtcpdump=enabled
else
GROUT_CONF_OPTS += -Dgrtcpdump=disabled
endif

$(eval $(meson-package))
