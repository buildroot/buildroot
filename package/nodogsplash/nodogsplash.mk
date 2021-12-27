################################################################################
#
# nodogsplash
#
################################################################################
NODOGSPLASH_VERSION = v4.5.1
NODOGSPLASH_SITE = git://github.com/nodogsplash/nodogsplash.git
NODOGSPLASH_SITE_METHOD = git
NODOGSPLASH_LICENSE = GPL-2.0
NODOGSPLASH_LICENSE_FILES = COPYING
NODOGSPLASH_DEPENDENCIES = libmicrohttpd
NODOGSPLASH_INSTALL_STAGING = YES

define NODOGSPLASH_BUILD_CMDS
	$(MAKE1) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)
endef

define NODOGSPLASH_INSTALL_EXTRA_FILES
	mkdir -p $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/etc/nodogsplash/htdocs/images
	cp $(@D)/resources/nodogsplash.conf $(TARGET_DIR)/etc/nodogsplash/
	cp $(@D)/resources/splash.html $(TARGET_DIR)/etc/nodogsplash/htdocs/
	cp $(@D)/resources/splash.css $(TARGET_DIR)/etc/nodogsplash/htdocs/
	cp $(@D)/resources/status.html $(TARGET_DIR)/etc/nodogsplash/htdocs/
	cp $(@D)/resources/splash.jpg $(TARGET_DIR)/etc/nodogsplash/htdocs/images/
endef

NODOGSPLASH_POST_INSTALL_TARGET_HOOKS += NODOGSPLASH_INSTALL_EXTRA_FILES

define NODOGSPLASH_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/nodogsplash $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/ndsctl $(TARGET_DIR)/usr/bin

endef

$(eval $(generic-package))

