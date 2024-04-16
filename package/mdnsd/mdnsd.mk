################################################################################
#
# mdnsd
#
################################################################################

MDNSD_VERSION = 0.12
MDNSD_SITE = https://github.com/troglobit/mdnsd/releases/download/v$(MDNSD_VERSION)
MDNSD_LICENSE = BSD-3-Clause
MDNSD_LICENSE_FILES = LICENSE
MDNSD_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_MDNSD_MQUERY),y)
MDNSD_CONF_OPTS += --with-mquery
else
MDNSD_CONF_OPTS += --without-mquery
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
MDNSD_DEPENDENCIES += systemd
MDNSD_CONF_OPTS += --with-systemd
else
MDNSD_CONF_OPTS += --without-systemd
endif

MDNSD_SERVICES_$(BR2_PACKAGE_MDNSD_FTP_SERVICE) += ftp
MDNSD_SERVICES_$(BR2_PACKAGE_MDNSD_HTTP_SERVICE) += http
MDNSD_SERVICES_$(BR2_PACKAGE_MDNSD_IPP_SERVICE) += ipp
MDNSD_SERVICES_$(BR2_PACKAGE_MDNSD_PRINTER_SERVICE) += printer
MDNSD_SERVICES_$(BR2_PACKAGE_MDNSD_SSH_SERVICE) += ssh

define MDNSD_INSTALL_SERVICES
	$(foreach service,$(MDNSD_SERVICES_y),\
		$(INSTALL) -D -m 0644 package/mdnsd/$(service).service \
			$(TARGET_DIR)/etc/mdns.d/$(service).service
	)
endef
MDNSD_POST_INSTALL_TARGET_HOOKS += MDNSD_INSTALL_SERVICES

define MDNSD_INSTALL_INIT_SYSV
	$(INSTALL) -m 755 -D package/mdnsd/S50mdnsd \
		$(TARGET_DIR)/etc/init.d/S50mdnsd
endef

define MDNSD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/mdnsd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/mdnsd.service
endef

$(eval $(autotools-package))
