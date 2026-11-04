################################################################################
#
# httpdate
#
################################################################################

HTTPDATE_VERSION = 1.0.1
HTTPDATE_SITE = $(call github,twekkel,httpdate,v$(HTTPDATE_VERSION))
HTTPDATE_LICENSE = GPL-2.0+
HTTPDATE_LICENSE_FILES = LICENSE
HTTPDATE_DEPENDENCIES = host-pkgconf libcurl

define HTTPDATE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		LIBS="`$(PKG_CONFIG_HOST_BINARY) --libs libcurl` -lm"
endef

define HTTPDATE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		DESTDIR=$(TARGET_DIR) PREFIX=/usr install
endef

define HTTPDATE_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/httpdate/S43httpdate \
		$(TARGET_DIR)/etc/init.d/S43httpdate
endef

define HTTPDATE_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 package/httpdate/httpdate.service \
		$(TARGET_DIR)/usr/lib/systemd/system/httpdate.service
endef

$(eval $(generic-package))
