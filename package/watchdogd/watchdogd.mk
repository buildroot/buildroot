################################################################################
#
# watchdogd
#
################################################################################

WATCHDOGD_VERSION = 3.5
WATCHDOGD_SITE = https://github.com/troglobit/watchdogd/releases/download/$(WATCHDOGD_VERSION)
WATCHDOGD_LICENSE = ISC
WATCHDOGD_LICENSE_FILES = LICENSE
WATCHDOGD_CPE_ID_VENDOR = troglobit
WATCHDOGD_INSTALL_STAGING = YES
WATCHDOGD_DEPENDENCIES = host-pkgconf libconfuse libite libuev
WATCHDOGD_CONF_OPTS = --disable-compat --disable-examples --disable-test-mode
WATCHDOGD_SELINUX_MODULES = watchdog

ifneq ($(BR2_PACKAGE_WATCHDOGD_TEST_SUITE),y)
WATCHDOGD_CONF_OPTS += --disable-builtin-tests
else
WATCHDOGD_CONF_OPTS += --enable-builtin-tests
endif

ifeq ($(BR2_PACKAGE_WATCHDOGD_GENERIC_POLL),0)
WATCHDOGD_CONF_OPTS += --without-generic
else
WATCHDOGD_CONF_OPTS += --with-generic=$(BR2_PACKAGE_WATCHDOGD_GENERIC_POLL)
endif

ifeq ($(BR2_PACKAGE_WATCHDOGD_LOADAVG_POLL),0)
WATCHDOGD_CONF_OPTS += --without-loadavg
else
WATCHDOGD_CONF_OPTS += --with-loadavg=$(BR2_PACKAGE_WATCHDOGD_LOADAVG_POLL)
endif

ifeq ($(BR2_PACKAGE_WATCHDOGD_FILENR_POLL),0)
WATCHDOGD_CONF_OPTS += --without-filenr
else
WATCHDOGD_CONF_OPTS += --with-filenr=$(BR2_PACKAGE_WATCHDOGD_FILENR_POLL)
endif

ifeq ($(BR2_PACKAGE_WATCHDOGD_MEMINFO_POLL),0)
WATCHDOGD_CONF_OPTS += --without-meminfo
else
WATCHDOGD_CONF_OPTS += --with-meminfo=$(BR2_PACKAGE_WATCHDOGD_MEMINFO_POLL)
endif

define WATCHDOGD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/watchdogd/S01watchdogd \
		$(TARGET_DIR)/etc/init.d/S01watchdogd
endef

define WATCHDOGD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(WATCHDOGD_SRCDIR)/watchdogd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/watchdogd.service
endef

$(eval $(autotools-package))
