################################################################################
#
# palo
#
################################################################################

PALO_VERSION = 2.28
PALO_SITE = https://git.kernel.org/pub/scm/linux/kernel/git/deller/palo.git/snapshot
PALO_LICENSE = GPL-2.0
PALO_LICENSE_FILES = COPYING
PALO_INSTALL_IMAGES  = YES

define PALO_BUILD_CMDS
	# Dummy README to remove the dependency on lynx.
	touch $(@D)/README
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		CROSS_COMPILE=$(TARGET_CROSS) all makeipl
endef

define PALO_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/iplboot $(BINARIES_DIR)/iplboot
	$(INSTALL) -D -m 0755 $(@D)/palo/palo $(HOST_DIR)/bin/palo
endef

$(eval $(generic-package))
