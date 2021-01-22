################################################################################
#
# sysklogd
#
################################################################################

SYSKLOGD_VERSION = 2.2.0
SYSKLOGD_SITE = https://github.com/troglobit/sysklogd/releases/download/v$(SYSKLOGD_VERSION)
SYSKLOGD_LICENSE = BSD-3-Clause
SYSKLOGD_LICENSE_FILES = LICENSE
SYSKLOGD_CPE_ID_VALID = YES
SYSKLOGD_CONF_OPTS = --exec-prefix=/ --without-logger

define SYSKLOGD_INSTALL_SAMPLE_CONFIG
	$(INSTALL) -D -m 0644 package/sysklogd/syslog.conf \
		$(TARGET_DIR)/etc/syslog.conf
endef

SYSKLOGD_POST_INSTALL_TARGET_HOOKS += SYSKLOGD_INSTALL_SAMPLE_CONFIG

define SYSKLOGD_INSTALL_INIT_SYSV
	$(INSTALL) -m 755 -D package/sysklogd/S01syslogd \
		$(TARGET_DIR)/etc/init.d/S01syslogd
endef

define SYSKLOGD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(SYSKLOGD_PKGDIR)/syslogd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/syslogd.service
endef

$(eval $(autotools-package))
