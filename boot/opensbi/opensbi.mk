################################################################################
#
# opensbi
#
################################################################################

OPENSBI_VERSION = $(call qstrip,$(BR2_TARGET_OPENSBI_VERSION))

ifeq ($(OPENSBI_VERSION),custom)
# Handle custom OpenSBI tarballs as specified by the configuration
OPENSBI_TARBALL = $(call qstrip,$(BR2_TARGET_OPENSBI_CUSTOM_TARBALL_LOCATION))
OPENSBI_SITE = $(patsubst %/,%,$(dir $(OPENSBI_TARBALL)))
OPENSBI_SOURCE = $(notdir $(OPENSBI_TARBALL))
else ifeq ($(BR2_TARGET_OPENSBI_CUSTOM_GIT),y)
OPENSBI_SITE = $(call qstrip,$(BR2_TARGET_OPENSBI_CUSTOM_REPO_URL))
OPENSBI_SITE_METHOD = git
else
# Handle official OpenSBI versions
OPENSBI_SITE = $(call github,riscv,opensbi,v$(OPENSBI_VERSION))
endif

OPENSBI_LICENSE = BSD-2-Clause
ifeq ($(BR2_TARGET_OPENSBI_LATEST_VERSION),y)
OPENSBI_LICENSE_FILES = COPYING.BSD
endif
OPENSBI_INSTALL_TARGET = NO
OPENSBI_INSTALL_STAGING = YES

ifeq ($(BR2_TARGET_OPENSBI)$(BR2_TARGET_OPENSBI_LATEST_VERSION),y)
BR_NO_CHECK_HASH_FOR += $(OPENSBI_SOURCE)
endif

OPENSBI_MAKE_ENV = \
	CROSS_COMPILE=$(TARGET_CROSS)

OPENSBI_PLAT = $(call qstrip,$(BR2_TARGET_OPENSBI_PLAT))
ifneq ($(OPENSBI_PLAT),)
OPENSBI_MAKE_ENV += PLATFORM=$(OPENSBI_PLAT)
endif

ifeq ($(BR2_TARGET_OPENSBI_LINUX_PAYLOAD),y)
OPENSBI_DEPENDENCIES += linux
OPENSBI_MAKE_ENV += FW_PAYLOAD_PATH="$(BINARIES_DIR)/Image"
endif

ifeq ($(BR2_TARGET_OPENSBI_UBOOT_PAYLOAD),y)
OPENSBI_DEPENDENCIES += uboot
OPENSBI_MAKE_ENV += FW_PAYLOAD_PATH="$(BINARIES_DIR)/u-boot.bin"
ifeq ($(BR2_TARGET_OPENSBI_FW_FDT_PATH),y)
OPENSBI_MAKE_ENV += FW_FDT_PATH="$(BINARIES_DIR)/u-boot.dtb"
endif
endif

define OPENSBI_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(OPENSBI_MAKE_ENV) $(MAKE) -C $(@D)
endef

ifeq ($(BR2_TARGET_OPENSBI_INSTALL_DYNAMIC_IMG),y)
OPENSBI_INSTALL_IMAGES = YES
OPENSBI_FW_IMAGES += dynamic
endif

ifeq ($(BR2_TARGET_OPENSBI_INSTALL_JUMP_IMG),y)
OPENSBI_INSTALL_IMAGES = YES
OPENSBI_FW_IMAGES += jump
endif

ifeq ($(BR2_TARGET_OPENSBI_INSTALL_PAYLOAD_IMG),y)
OPENSBI_INSTALL_IMAGES = YES
OPENSBI_FW_IMAGES += payload
endif

ifneq ($(OPENSBI_PLAT),)
define OPENSBI_INSTALL_IMAGES_CMDS
	$(foreach f,$(OPENSBI_FW_IMAGES),\
		$(INSTALL) -m 0644 -D $(@D)/build/platform/$(OPENSBI_PLAT)/firmware/fw_$(f).bin \
			$(BINARIES_DIR)/fw_$(f).bin
		$(INSTALL) -m 0644 -D $(@D)/build/platform/$(OPENSBI_PLAT)/firmware/fw_$(f).elf \
			$(BINARIES_DIR)/fw_$(f).elf
	)
endef
endif

# libsbi.a is not a library meant to be linked in user-space code, but
# with bare metal code, which is why we don't install it in
# $(STAGING_DIR)/usr/lib
define OPENSBI_INSTALL_STAGING_CMDS
	$(INSTALL) -m 0644 -D $(@D)/build/lib/libsbi.a $(STAGING_DIR)/usr/share/opensbi/libsbi.a
endef

$(eval $(generic-package))
