################################################################################
#
# mrouted
#
################################################################################

MROUTED_VERSION = 4.2
MROUTED_SITE = \
	https://github.com/troglobit/mrouted/releases/download/$(MROUTED_VERSION)
MROUTED_DEPENDENCIES = host-bison
MROUTED_LICENSE = BSD-3-Clause
MROUTED_LICENSE_FILES = LICENSE
MROUTED_CONFIGURE_OPTS = --enable-rsrr
MROUTED_CPE_ID_VENDOR = troglobit

define MROUTED_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/mrouted.service \
		$(TARGET_DIR)/usr/lib/systemd/system/mrouted.service
endef

# We will asume that CONFIG_NET and CONFIG_INET are already
# set in the kernel configuration provided by the user.
define MROUTED_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_IP_MULTICAST)
	$(call KCONFIG_ENABLE_OPT,CONFIG_IP_MROUTE)
endef

$(eval $(autotools-package))
