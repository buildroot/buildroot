################################################################################
#
# shim
#
################################################################################

SHIM_VERSION = 15.8
SHIM_SITE = https://github.com/rhboot/shim/releases/download/$(SHIM_VERSION)
SHIM_SOURCE = shim-$(SHIM_VERSION).tar.bz2
SHIM_LICENSE = BSD-2-Clause
SHIM_LICENSE_FILES = COPYRIGHT
SHIM_CPE_ID_VENDOR = redhat
SHIM_INSTALL_TARGET = NO
SHIM_INSTALL_IMAGES = YES

SHIM_CFLAGS = $(TARGET_CFLAGS)
SHIM_MAKE_OPTS = \
	ARCH="$(GNU_EFI_PLATFORM)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	DASHJ="-j$(PARALLEL_JOBS)" \
	OPTIMIZATIONS="$(SHIM_CFLAGS)"

# shim has some assembly function that is not present in Thumb mode:
# Error: selected processor does not support `mrc p15,0,r2,c9,c13,0' in Thumb mode
# so, we deactivate Thumb mode
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
SHIM_CFLAGS += -marm
endif

define SHIM_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) $(SHIM_MAKE_OPTS)
endef

define SHIM_INSTALL_IMAGES_CMDS
	$(INSTALL) -m 0755 -t $(BINARIES_DIR) $(@D)/*.efi
endef

$(eval $(generic-package))
