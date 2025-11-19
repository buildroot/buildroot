################################################################################
#
# kibi
#
################################################################################

KIBI_VERSION = 0.3.1
KIBI_SITE = $(call github,ilai-deutel,kibi,v$(KIBI_VERSION))
KIBI_LICENSE = MIT or Apache-2.0
KIBI_LICENSE_FILES = LICENSE-MIT LICENSE-APACHE

ifeq ($(BR2_PACKAGE_KIBI_SYNTAX_HIGHLIGHTING),y)
define KIBI_INSTALL_SYNTAX_HIGHLIGHTING
	mkdir -p $(TARGET_DIR)/usr/share/kibi/syntax.d
	cp -dpfr $(@D)/syntax.d/*.ini $(TARGET_DIR)/usr/share/kibi/syntax.d/
endef

KIBI_POST_INSTALL_TARGET_HOOKS += KIBI_INSTALL_SYNTAX_HIGHLIGHTING
endif

$(eval $(cargo-package))
