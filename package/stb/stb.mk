################################################################################
#
# stb
#
################################################################################

STB_VERSION = 8b5f1f37b5b75829fc72d38e7b5d4bcbf8a26d55
STB_SITE = $(call github,nothings,stb,$(STB_VERSION))
STB_LICENSE = Public Domain or MIT
STB_LICENSE_FILES = LICENSE
STB_INSTALL_STAGING = YES
STB_INSTALL_TARGET = NO

define STB_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/stb
	$(INSTALL) -m 0644 $(@D)/*.h $(STAGING_DIR)/usr/include/stb
	$(INSTALL) -D -m 0644 $(STB_PKGDIR)/stb.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/stb.pc
endef

$(eval $(generic-package))
