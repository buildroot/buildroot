################################################################################
#
# tbtools
#
################################################################################

TBTOOLS_VERSION = 0.6.0
TBTOOLS_SITE = $(call github,intel,tbtools,v$(TBTOOLS_VERSION))
TBTOOLS_LICENSE = MIT
TBTOOLS_LICENSE_FILES = LICENSE
TBTOOLS_DEPENDENCIES = udev

define TBTOOLS_INSTALL_SCRIPTS
	$(MAKE) -C $(@D) PREFIX=$(TARGET_DIR)/usr install-scripts
endef
TBTOOLS_POST_INSTALL_TARGET_HOOKS += TBTOOLS_INSTALL_SCRIPTS

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
define TBTOOLS_INSTALL_COMPLETION
	$(MAKE) -C $(@D) PREFIX=$(TARGET_DIR)/usr install-completion
endef
TBTOOLS_POST_INSTALL_TARGET_HOOKS += TBTOOLS_INSTALL_COMPLETION
endif

$(eval $(cargo-package))
