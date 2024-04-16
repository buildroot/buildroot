################################################################################
#
# darkhttpd
#
################################################################################

DARKHTTPD_VERSION = 1.15
DARKHTTPD_SITE = $(call github,emikulic,darkhttpd,v$(DARKHTTPD_VERSION))
DARKHTTPD_LICENSE = ISC
DARKHTTPD_LICENSE_FILES = COPYING
DARKHTTPD_CPE_ID_VALID = YES

define DARKHTTPD_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define DARKHTTPD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/darkhttpd \
		$(TARGET_DIR)/usr/sbin/darkhttpd
endef

define DARKHTTPD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 package/darkhttpd/darkhttpd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/darkhttpd.service
endef

define DARKHTTPD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/darkhttpd/S50darkhttpd \
		$(TARGET_DIR)/etc/init.d/S50darkhttpd
endef

$(eval $(generic-package))
