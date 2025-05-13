################################################################################
#
# grout
#
################################################################################

GROUT_VERSION = 0.10.0
GROUT_SITE = $(call github,DPDK,grout,v$(GROUT_VERSION))
GROUT_LICENSE = BSD-3-Clause
GROUT_LICENSE_FILES = LICENSE

# Avoid using buildroot commit hash
GROUT_CONF_ENV = GROUT_VERSION=$(GROUT_VERSION)

GROUT_DEPENDENCIES = \
	host-pkgconf \
	dpdk \
	libevent \
	numactl \
	libecoli \
	util-linux

$(eval $(meson-package))
