################################################################################
#
# memtest86
#
################################################################################

MEMTEST86_VERSION = 7.20
MEMTEST86_SITE = $(call github,memtest86plus,memtest86plus,v$(MEMTEST86_VERSION))
MEMTEST86_LICENSE = GPL-2.0
MEMTEST86_LICENSE_FILES = LICENSE
MEMTEST86_INSTALL_IMAGES = YES
MEMTEST86_INSTALL_TARGET = NO

ifeq ($(BR2_i386),y)
MEMTEST86_BUILD_DIR = build32
else
ifeq ($(BR2_x86_64),y)
MEMTEST86_BUILD_DIR = build64
endif
endif

define MEMTEST86_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/$(MEMTEST86_BUILD_DIR)
endef

define MEMTEST86_INSTALL_IMAGES_CMDS
	$(foreach ext, bin efi, \
		$(INSTALL) -m 0755 -D $(@D)/$(MEMTEST86_BUILD_DIR)/memtest.$(ext) \
			$(BINARIES_DIR)/memtest.$(ext)
	)
endef

$(eval $(generic-package))
