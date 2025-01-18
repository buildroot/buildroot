################################################################################
#
# taglib
#
################################################################################

UTFCPP_VERSION = 4.0.6
UTFCPP_SITE = $(call github,nemtrif,utfcpp,v$(UTFCPP_VERSION))
UTFCPP_LICENSE = BSL-1.0
UTFCPP_LICENSE_FILES = LICENSE

# utfcpp is a header-only library, it only makes sense
# to have it installed into the staging directory.
UTFCPP_INSTALL_STAGING = YES
UTFCPP_INSTALL_TARGET = NO

define UTFCPP_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/utf8/
	$(INSTALL) -m 0644 $(@D)/source/utf8.h $(STAGING_DIR)/usr/include/utf8.h
	$(INSTALL) -m 0644 $(@D)/source/utf8/* $(STAGING_DIR)/usr/include/utf8/
endef

$(eval $(generic-package))
