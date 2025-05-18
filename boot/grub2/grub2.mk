################################################################################
#
# grub2
#
################################################################################

GRUB2_VERSION = 2.12
GRUB2_SITE = $(BR2_GNU_MIRROR)/grub
GRUB2_SOURCE = grub-$(GRUB2_VERSION).tar.xz
GRUB2_LICENSE = GPL-3.0+
GRUB2_LICENSE_FILES = COPYING
GRUB2_DEPENDENCIES = host-bison host-flex host-gawk host-grub2 \
	$(BR2_PYTHON3_HOST_DEPENDENCY)
HOST_GRUB2_DEPENDENCIES = host-bison host-flex host-gawk \
	$(BR2_PYTHON3_HOST_DEPENDENCY)
GRUB2_INSTALL_IMAGES = YES

# CVE-2019-14865 is about a flaw in the grub2-set-bootflag tool, which
# doesn't exist upstream, but is added by the Redhat/Fedora
# packaging. Not applicable to Buildroot.
GRUB2_IGNORE_CVES += CVE-2019-14865
# vulnerability is specific to the Redhat distribution, affects a
# downstream change from Redhat related to password authentication
GRUB2_IGNORE_CVES += CVE-2023-4001
# vulnerability is specific to the Redhat distribution, affects the
# grub2-set-bootflag tool, which doesn't exist upstream
GRUB2_IGNORE_CVES += CVE-2024-1048

ifeq ($(BR2_TARGET_GRUB2_INSTALL_TOOLS),y)
GRUB2_INSTALL_TARGET = YES
else
GRUB2_INSTALL_TARGET = NO
endif
GRUB2_CPE_ID_VENDOR = gnu

GRUB2_BUILTIN_MODULES_PC = $(call qstrip,$(BR2_TARGET_GRUB2_BUILTIN_MODULES_PC))
GRUB2_BUILTIN_MODULES_EFI = $(call qstrip,$(BR2_TARGET_GRUB2_BUILTIN_MODULES_EFI))
GRUB2_BUILTIN_CONFIG_PC = $(call qstrip,$(BR2_TARGET_GRUB2_BUILTIN_CONFIG_PC))
GRUB2_BUILTIN_CONFIG_EFI = $(call qstrip,$(BR2_TARGET_GRUB2_BUILTIN_CONFIG_EFI))
GRUB2_BOOT_PARTITION = $(call qstrip,$(BR2_TARGET_GRUB2_BOOT_PARTITION))

GRUB2_IMAGE_i386-pc = $(BINARIES_DIR)/grub.img
GRUB2_CFG_i386-pc = $(TARGET_DIR)/boot/grub/grub.cfg
GRUB2_PREFIX_i386-pc = ($(GRUB2_BOOT_PARTITION))/boot/grub
GRUB2_TARGET_i386-pc = i386
GRUB2_PLATFORM_i386-pc = pc
GRUB2_BUILTIN_CONFIG_i386-pc = $(GRUB2_BUILTIN_CONFIG_PC)
GRUB2_BUILTIN_MODULES_i386-pc = $(GRUB2_BUILTIN_MODULES_PC)
GRUB2_TUPLES-$(BR2_TARGET_GRUB2_I386_PC) += i386-pc

GRUB2_IMAGE_i386-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/bootia32.efi
GRUB2_CFG_i386-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/grub.cfg
GRUB2_PREFIX_i386-efi = /EFI/BOOT
GRUB2_TARGET_i386-efi = i386
GRUB2_PLATFORM_i386-efi = efi
GRUB2_BUILTIN_CONFIG_i386-efi = $(GRUB2_BUILTIN_CONFIG_EFI)
GRUB2_BUILTIN_MODULES_i386-efi = $(GRUB2_BUILTIN_MODULES_EFI)
GRUB2_TUPLES-$(BR2_TARGET_GRUB2_I386_EFI) += i386-efi

GRUB2_IMAGE_x86_64-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/bootx64.efi
GRUB2_CFG_x86_64-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/grub.cfg
GRUB2_PREFIX_x86_64-efi = /EFI/BOOT
GRUB2_TARGET_x86_64-efi = x86_64
GRUB2_PLATFORM_x86_64-efi = efi
GRUB2_BUILTIN_CONFIG_x86_64-efi = $(GRUB2_BUILTIN_CONFIG_EFI)
GRUB2_BUILTIN_MODULES_x86_64-efi = $(GRUB2_BUILTIN_MODULES_EFI)
GRUB2_TUPLES-$(BR2_TARGET_GRUB2_X86_64_EFI) += x86_64-efi

GRUB2_IMAGE_arm-uboot = $(BINARIES_DIR)/boot-part/grub/grub.img
GRUB2_CFG_arm-uboot = $(BINARIES_DIR)/boot-part/grub/grub.cfg
GRUB2_PREFIX_arm-uboot = ($(GRUB2_BOOT_PARTITION))/boot/grub
GRUB2_TARGET_arm-uboot = arm
GRUB2_PLATFORM_arm-uboot = uboot
GRUB2_BUILTIN_CONFIG_arm-uboot = $(GRUB2_BUILTIN_CONFIG_PC)
GRUB2_BUILTIN_MODULES_arm-uboot = $(GRUB2_BUILTIN_MODULES_PC)
GRUB2_TUPLES-$(BR2_TARGET_GRUB2_ARM_UBOOT) += arm-uboot

GRUB2_IMAGE_arm-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/bootarm.efi
GRUB2_CFG_arm-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/grub.cfg
GRUB2_PREFIX_arm-efi = /EFI/BOOT
GRUB2_TARGET_arm-efi = arm
GRUB2_PLATFORM_arm-efi = efi
GRUB2_BUILTIN_CONFIG_arm-efi = $(GRUB2_BUILTIN_CONFIG_EFI)
GRUB2_BUILTIN_MODULES_arm-efi = $(GRUB2_BUILTIN_MODULES_EFI)
GRUB2_TUPLES-$(BR2_TARGET_GRUB2_ARM_EFI) += arm-efi

GRUB2_IMAGE_arm64-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/bootaa64.efi
GRUB2_CFG_arm64-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/grub.cfg
GRUB2_PREFIX_arm64-efi = /EFI/BOOT
GRUB2_TARGET_arm64-efi = aarch64
GRUB2_PLATFORM_arm64-efi = efi
GRUB2_BUILTIN_CONFIG_arm64-efi = $(GRUB2_BUILTIN_CONFIG_EFI)
GRUB2_BUILTIN_MODULES_arm64-efi = $(GRUB2_BUILTIN_MODULES_EFI)
GRUB2_TUPLES-$(BR2_TARGET_GRUB2_ARM64_EFI) += arm64-efi

GRUB2_IMAGE_riscv64-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/bootriscv64.efi
GRUB2_CFG_riscv64-efi = $(BINARIES_DIR)/efi-part/EFI/BOOT/grub.cfg
GRUB2_PREFIX_riscv64-efi = /EFI/BOOT
GRUB2_TARGET_riscv64-efi = riscv64
GRUB2_PLATFORM_riscv64-efi = efi
GRUB2_BUILTIN_CONFIG_riscv64-efi = $(GRUB2_BUILTIN_CONFIG_EFI)
GRUB2_BUILTIN_MODULES_riscv64-efi = $(GRUB2_BUILTIN_MODULES_EFI)
GRUB2_TUPLES-$(BR2_TARGET_GRUB2_RISCV64_EFI) += riscv64-efi

# Grub2 is kind of special: it considers CC, LD and so on to be the
# tools to build the host programs and uses TARGET_CC, TARGET_CFLAGS,
# TARGET_CPPFLAGS, TARGET_LDFLAGS to build the bootloader itself.
#
# NOTE: TARGET_STRIP is overridden by !BR2_STRIP_strip, so always
# use the cross compile variant to ensure grub2 builds

HOST_GRUB2_CONF_ENV = \
	CPP="$(HOSTCC) -E"

GRUB2_CONF_ENV = \
	CPP="$(TARGET_CC) -E" \
	TARGET_CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS) -Os" \
	TARGET_CFLAGS="$(TARGET_CFLAGS) -Os" \
	CPPFLAGS="$(TARGET_CPPFLAGS) -Os -fno-stack-protector" \
	TARGET_CPPFLAGS="$(TARGET_CPPFLAGS) -Os -fno-stack-protector" \
	TARGET_LDFLAGS="$(TARGET_LDFLAGS) -Os" \
	TARGET_NM="$(TARGET_NM)" \
	TARGET_OBJCOPY="$(TARGET_OBJCOPY)" \
	TARGET_STRIP="$(TARGET_CROSS)strip"

HOST_GRUB2_CONF_OPTS = \
	--with-platform=none \
	--disable-grub-mkfont \
	--enable-efiemu=no \
	ac_cv_lib_lzma_lzma_code=no \
	--enable-device-mapper=no \
	--enable-libzfs=no \
	--disable-werror

define GRUB2_CONFIGURE_CMDS
	$(foreach tuple, $(GRUB2_TUPLES-y), \
		@$(call MESSAGE,Configuring $(tuple))
		mkdir -p $(@D)/build-$(tuple)
		cd $(@D)/build-$(tuple) && \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		$(GRUB2_CONF_ENV) \
		../configure \
			--target=$(GRUB2_TARGET_$(tuple)) \
			--with-platform=$(GRUB2_PLATFORM_$(tuple)) \
			--host=$(GNU_TARGET_NAME) \
			--build=$(GNU_HOST_NAME) \
			--prefix=/ \
			--exec-prefix=/ \
			--disable-grub-mkfont \
			--enable-efiemu=no \
			ac_cv_lib_lzma_lzma_code=no \
			--enable-device-mapper=no \
			--enable-libzfs=no \
			--disable-werror
	)
endef

define GRUB2_BUILD_CMDS
	$(foreach tuple, $(GRUB2_TUPLES-y), \
		@$(call MESSAGE,Building $(tuple))
		$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/build-$(tuple)
	)
endef

define GRUB2_INSTALL_IMAGES_CMDS
	$(foreach tuple, $(GRUB2_TUPLES-y), \
		@$(call MESSAGE,Installing $(tuple) to images directory)
		mkdir -p $(dir $(GRUB2_IMAGE_$(tuple)))
		$(HOST_DIR)/bin/grub-mkimage \
			-d $(@D)/build-$(tuple)/grub-core/ \
			-O $(tuple) \
			-o $(GRUB2_IMAGE_$(tuple)) \
			-p "$(GRUB2_PREFIX_$(tuple))" \
			$(if $(GRUB2_BUILTIN_CONFIG_$(tuple)), \
				-c $(GRUB2_BUILTIN_CONFIG_$(tuple))) \
			$(GRUB2_BUILTIN_MODULES_$(tuple))
		$(INSTALL) -D -m 0644 boot/grub2/grub.cfg $(GRUB2_CFG_$(tuple))
		$(if $(findstring $(GRUB2_PLATFORM_$(tuple)), pc), \
			cat $(@D)/build-$(tuple)/grub-core/cdboot.img $(GRUB2_IMAGE_$(tuple)) > \
				$(BINARIES_DIR)/grub-eltorito.img
		) \
	)
endef

ifeq ($(BR2_TARGET_GRUB2_INSTALL_TOOLS),y)
define GRUB2_INSTALL_TARGET_CMDS
	$(foreach tuple, $(GRUB2_TUPLES-y), \
		@$(call MESSAGE,Installing $(tuple) to target directory)
		$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/build-$(tuple) DESTDIR=$(TARGET_DIR) install
	)
endef
endif

$(eval $(generic-package))
$(eval $(host-autotools-package))
