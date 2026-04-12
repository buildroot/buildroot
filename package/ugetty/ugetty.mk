################################################################################
#
# ugetty
#
################################################################################

UGETTY_VERSION = f1b7858778800b7256e9874f266c1d16ced22a6e
UGETTY_SITE = $(call github,ryancdotorg,ugetty,$(UGETTY_VERSION))
UGETTY_LICENSE = BSD-0-Clause or MIT or CC0-1.0
UGETTY_LICENSE_FILES = LICENSE LICENSE.0BSD LICENSE.CC0 LICENSE.MIT-0

define UGETTY_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) bin/ugetty
endef

# Install ugetty->getty symlink to ensure ugetty is used
define UGETTY_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/bin/ugetty \
		$(TARGET_DIR)/sbin/ugetty
	ln -snf ugetty $(TARGET_DIR)/sbin/getty
endef

$(eval $(generic-package))
