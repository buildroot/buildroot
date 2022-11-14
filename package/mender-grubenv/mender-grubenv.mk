################################################################################
#
# mender-grubenv
#
################################################################################

MENDER_GRUBENV_VERSION = 2ac898f5924d5870f8394ad8ecd3ef1ab1422e3b
MENDER_GRUBENV_SITE = $(call github,mendersoftware,grub-mender-grubenv,$(MENDER_GRUBENV_VERSION))
MENDER_GRUBENV_LICENSE = Apache-2.0
MENDER_GRUBENV_LICENSE_FILES = LICENSE
# Grub2 must be built first so this package can overwrite the config files
# provided by grub.
MENDER_GRUBENV_DEPENDENCIES = grub2
MENDER_GRUBENV_INSTALL_IMAGES = YES

MENDER_GRUBENV_MAKE_ENV = \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV)

MENDER_GRUBENV_DEFINES = \
	$(or $(call qstrip,$(BR2_PACKAGE_MENDER_GRUBENV_DEFINES)),\
		$(@D)/mender_grubenv_defines.example)

# These grub modules must be built in for the grub scripts to work properly.
# Without them, the system will not boot.
MENDER_GRUBENV_MANDATORY_MODULES = loadenv hashsum echo halt gcry_sha256 test regexp

ifeq ($(BR2_TARGET_GRUB2_HAS_LEGACY_BOOT),y)
MENDER_GRUBENV_MODULES_MISSING_PC = \
	$(filter-out $(call qstrip,$(BR2_TARGET_GRUB2_BUILTIN_MODULES_PC)),\
		$(MENDER_GRUBENV_MANDATORY_MODULES))

MENDER_GRUBENV_MAKE_ENV += BOOT_DIR=/boot/grub

define MENDER_GRUBENV_INSTALL_I386_CFG
	mkdir -p $(BINARIES_DIR)/boot-part/grub
	cp -dpfr $(@D)/mender_grub.cfg \
		$(TARGET_DIR)/boot/grub/grub.cfg
	cp -dpfr $(TARGET_DIR)/boot/grub/grub.cfg \
		$(TARGET_DIR)/boot/grub/grub-mender-grubenv \
		$(BINARIES_DIR)/boot-part/
endef
endif # BR2_TARGET_GRUB2_HAS_LEGACY_BOOT

ifeq ($(BR2_TARGET_GRUB2_HAS_EFI_BOOT),y)
MENDER_GRUBENV_MODULES_MISSING_EFI = \
	$(filter-out $(call qstrip,$(BR2_TARGET_GRUB2_BUILTIN_MODULES_EFI)),\
		$(MENDER_GRUBENV_MANDATORY_MODULES))

MENDER_GRUBENV_MAKE_ENV += BOOT_DIR=/boot/EFI/BOOT

define MENDER_GRUBENV_INSTALL_EFI_CFG
	mkdir -p $(BINARIES_DIR)/efi-part/EFI/BOOT
	cp -dpfr $(@D)/mender_grub.cfg \
		$(TARGET_DIR)/boot/EFI/BOOT/grub.cfg
	cp -dpfr $(TARGET_DIR)/boot/EFI/BOOT/grub.cfg \
		$(BINARIES_DIR)/efi-part/EFI/BOOT
	cp -dpfr $(TARGET_DIR)/boot/EFI/BOOT/grub-mender-grubenv \
		$(BINARIES_DIR)/efi-part/
endef
endif # BR2_TARGET_GRUB2_HAS_EFI_BOOT

ifeq ($(BR2_PACKAGE_MENDER_GRUBENV)$(BR_BUILDING),yy)
ifneq ($(MENDER_GRUBENV_MODULES_MISSING_EFI),)
$(error The following missing grub2 efi modules must be enabled for mender-grubenv \
	to work: $(MENDER_GRUBENV_MODULES_MISSING_EFI))
endif
ifneq ($(MENDER_GRUBENV_MODULES_MISSING_PC),)
$(error The following missing grub2 pc modules must be enabled for mender-grubenv \
	to work: $(MENDER_GRUBENV_MODULES_MISSING_PC))
endif
endif

define MENDER_GRUBENV_CONFIGURE_CMDS
	$(INSTALL) -m 0644 $(MENDER_GRUBENV_DEFINES) $(@D)/mender_grubenv_defines
endef

define MENDER_GRUBENV_BUILD_CMDS
	$(MENDER_GRUBENV_MAKE_ENV) $(MAKE) -C $(@D)
endef

define MENDER_GRUBENV_INSTALL_TARGET_CMDS
	$(MENDER_GRUBENV_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) -C $(@D) \
		install install-boot-env
	# The grub-mender-grubenv-* utilities use this file to function.
	echo 'ENV_DIR=/boot/grub-mender-grubenv' > $(TARGET_DIR)/etc/mender_grubenv.config
endef

define MENDER_GRUBENV_INSTALL_IMAGES_CMDS
	$(MENDER_GRUBENV_INSTALL_I386_CFG)
	$(MENDER_GRUBENV_INSTALL_EFI_CFG)
endef

$(eval $(generic-package))
