################################################################################
#
# ssdp-responder
#
################################################################################

SSDP_RESPONDER_VERSION = 2.1
SSDP_RESPONDER_SITE = https://github.com/troglobit/ssdp-responder/releases/download/v$(SSDP_RESPONDER_VERSION)
SSDP_RESPONDER_LICENSE = ISC
SSDP_RESPONDER_LICENSE_FILES = LICENSE
SSDP_RESPONDER_CPE_ID_VENDOR = \
	simple_service_discovery_protocol_responder_project
SSDP_RESPONDER_CPE_ID_PRODUCT = simple_service_discovery_protocol_responder
SSDP_RESPONDER_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
SSDP_RESPONDER_DEPENDENCIES += systemd
SSDP_RESPONDER_CONF_OPTS += --with-systemd
else
SSDP_RESPONDER_CONF_OPTS += --without-systemd
endif

define SSDP_RESPONDER_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/ssdp-responder/S50ssdpd \
		$(TARGET_DIR)/etc/init.d/S50ssdpd
endef

define SSDP_RESPONDER_INSTALL_INIT_SYSTEMD
	mkdir -p $(TARGET_DIR)/var/lib/misc/
endef

$(eval $(autotools-package))
