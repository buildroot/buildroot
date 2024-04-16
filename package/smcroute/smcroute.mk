################################################################################
#
# smcroute
#
################################################################################

SMCROUTE_VERSION = 2.5.6
SMCROUTE_SITE = https://github.com/troglobit/smcroute/releases/download/$(SMCROUTE_VERSION)
SMCROUTE_LICENSE = GPL-2.0+
SMCROUTE_LICENSE_FILES = COPYING
SMCROUTE_CPE_ID_VENDOR = troglobit

SMCROUTE_CONF_OPTS = --enable-mrdisc

ifeq ($(BR2_PACKAGE_LIBCAP),y)
SMCROUTE_DEPENDENCIES += libcap
SMCROUTE_CONF_OPTS += --with-libcap
else
SMCROUTE_CONF_OPTS += --without-libcap
endif

define SMCROUTE_INSTALL_INIT_SYSV
	$(INSTALL) -m 755 -D package/smcroute/S41smcroute \
		$(TARGET_DIR)/etc/init.d/S41smcroute
endef

define SMCROUTE_PRUNE_COMPAT_SCRIPT
	rm -f $(TARGET_DIR)/usr/sbin/smcroute
endef

SMCROUTE_POST_INSTALL_TARGET_HOOKS += SMCROUTE_PRUNE_COMPAT_SCRIPT

# We will asume that CONFIG_NET and CONFIG_INET are already
# set in the kernel configuration provided by the user.
define SMCROUTE_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_IP_MULTICAST)
	$(call KCONFIG_ENABLE_OPT,CONFIG_IP_MROUTE)
endef

$(eval $(autotools-package))
