################################################################################
#
# duktape
#
################################################################################

DUKTAPE_VERSION = 2.7.0
DUKTAPE_SOURCE = duktape-$(DUKTAPE_VERSION).tar.xz
DUKTAPE_SITE = \
	https://github.com/svaarala/duktape/releases/download/v$(DUKTAPE_VERSION)
DUKTAPE_LICENSE = MIT
DUKTAPE_LICENSE_FILES = LICENSE.txt
DUKTAPE_INSTALL_STAGING = YES
DUKTAPE_CPE_ID_VALID = YES

define DUKTAPE_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) -f Makefile.sharedlibrary
endef

define DUKTAPE_INSTALL_STAGING_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) -f Makefile.sharedlibrary \
		INSTALL_PREFIX=$(STAGING_DIR)/usr install
	$(INSTALL) -D -m 0644 $(DUKTAPE_PKGDIR)/duktape.pc.in \
		$(STAGING_DIR)/usr/lib/pkgconfig/duktape.pc
	$(SED) 's/@VERSION@/$(DUKTAPE_VERSION)/g;' \
		$(STAGING_DIR)/usr/lib/pkgconfig/duktape.pc
endef

define DUKTAPE_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) -f Makefile.sharedlibrary \
		INSTALL_PREFIX=$(TARGET_DIR)/usr install
endef

$(eval $(generic-package))
