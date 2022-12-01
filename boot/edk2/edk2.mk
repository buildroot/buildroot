################################################################################
#
# edk2
#
################################################################################

EDK2_VERSION = edk2-stable202208
EDK2_SITE = https://github.com/tianocore/edk2
EDK2_SITE_METHOD = git
EDK2_LICENSE = BSD-2-Clause
EDK2_LICENSE_FILES = License.txt
EDK2_CPE_ID_VENDOR = tianocore
EDK2_DEPENDENCIES = edk2-platforms host-python3 host-acpica host-util-linux
EDK2_INSTALL_TARGET = NO
EDK2_INSTALL_IMAGES = YES

ifeq ($(BR2_ENABLE_DEBUG),y)
EDK2_BUILD_TYPE = DEBUG
else
EDK2_BUILD_TYPE = RELEASE
endif

# Build system notes.
#
# The EDK2 build system is rather unique, so here are a few useful notes.
#
# First, builds rely heavily on Git submodules to fetch various dependencies
# into specific directory structures. It might be possible to work around this
# and rely on Buildroot's infrastructure, but using Git submodules greatly
# simplifies this already complicated build system.
#
# Second, the build system is spread across various commands and stages.
# Therefore, all build variables needs to be exported to be available
# accordingly. The first stage will build $(@D)/BaseTools which contains
# various tools and scripts for the host.
#
# Third, where applicable, the dependency direction between EDK2 and
# ARM Trusted Firmware (ATF) will go in different direction for different
# platforms. Most commonly, ATF will depend on EDK2 via the BL33 payload.
# But for some platforms (e.g. QEMU SBSA or DeveloperBox) EDK2 will package
# the ATF images within its own build system. In such cases, intermediary
# "EDK2 packages" will be built in $(EDK2_BUILD_PACKAGES) in order for EDK2
# to be able to use them in subsequent build stages.
#
# For more information about the build setup:
# https://edk2-docs.gitbook.io/edk-ii-build-specification/4_edk_ii_build_process_overview

EDK2_GIT_SUBMODULES = YES
EDK2_BUILD_PACKAGES = $(@D)/Build/Buildroot
EDK2_PACKAGES_PATHS = $(@D) $(EDK2_BUILD_PACKAGES) $(STAGING_DIR)/usr/share/edk2-platforms

ifeq ($(BR2_TARGET_EDK2_PLATFORM_OVMF_I386),y)
EDK2_ARCH = IA32
EDK2_DEPENDENCIES += host-nasm
EDK2_PACKAGE_NAME = OvmfPkg
EDK2_PLATFORM_NAME = OvmfPkgIa32
EDK2_BUILD_DIR = OvmfIa32

else ifeq ($(BR2_TARGET_EDK2_PLATFORM_OVMF_X64),y)
EDK2_ARCH = X64
EDK2_DEPENDENCIES += host-nasm
EDK2_PACKAGE_NAME = OvmfPkg
EDK2_PLATFORM_NAME = OvmfPkgX64
EDK2_BUILD_DIR = OvmfX64

else ifeq ($(BR2_TARGET_EDK2_PLATFORM_ARM_VIRT_QEMU),y)
EDK2_ARCH = AARCH64
EDK2_PACKAGE_NAME = ArmVirtPkg
EDK2_PLATFORM_NAME = ArmVirtQemu
EDK2_BUILD_DIR = $(EDK2_PLATFORM_NAME)-$(EDK2_ARCH)

else ifeq ($(BR2_TARGET_EDK2_PLATFORM_ARM_VIRT_QEMU_KERNEL),y)
EDK2_ARCH = AARCH64
EDK2_PACKAGE_NAME = ArmVirtPkg
EDK2_PLATFORM_NAME = ArmVirtQemuKernel
EDK2_BUILD_DIR = $(EDK2_PLATFORM_NAME)-$(EDK2_ARCH)

else ifeq ($(BR2_TARGET_EDK2_PLATFORM_ARM_VEXPRESS_FVP_AARCH64),y)
EDK2_ARCH = AARCH64
EDK2_PACKAGE_NAME = Platform/ARM/VExpressPkg
EDK2_PLATFORM_NAME = ArmVExpress-FVP-AArch64
EDK2_BUILD_DIR = $(EDK2_PLATFORM_NAME)

else ifeq ($(BR2_TARGET_EDK2_PLATFORM_SOCIONEXT_DEVELOPERBOX),y)
EDK2_ARCH = AARCH64
EDK2_DEPENDENCIES += host-dtc arm-trusted-firmware
EDK2_PACKAGE_NAME = Platform/Socionext/DeveloperBox
EDK2_PLATFORM_NAME = DeveloperBox
EDK2_BUILD_DIR = $(EDK2_PLATFORM_NAME)
EDK2_BUILD_ENV += DTC_PREFIX=$(HOST_DIR)/bin/
EDK2_BUILD_OPTS += -D DO_X86EMU=TRUE
EDK2_PRE_BUILD_HOOKS += EDK2_PRE_BUILD_SOCIONEXT_DEVELOPERBOX

define EDK2_PRE_BUILD_SOCIONEXT_DEVELOPERBOX
	mkdir -p $(EDK2_BUILD_PACKAGES)/Platform/Socionext/DeveloperBox
	$(ARM_TRUSTED_FIRMWARE_DIR)/tools/fiptool/fiptool create \
		--tb-fw $(BINARIES_DIR)/bl31.bin \
		--soc-fw $(BINARIES_DIR)/bl31.bin \
		--scp-fw $(BINARIES_DIR)/bl31.bin \
		$(EDK2_BUILD_PACKAGES)/Platform/Socionext/DeveloperBox/fip_all_arm_tf.bin
endef

else ifeq ($(BR2_TARGET_EDK2_PLATFORM_SOLIDRUN_ARMADA80X0MCBIN),y)
EDK2_ARCH = AARCH64
EDK2_DEPENDENCIES += host-dtc arm-trusted-firmware edk2-non-osi
EDK2_PACKAGE_NAME = Platform/SolidRun/Armada80x0McBin
EDK2_PLATFORM_NAME = Armada80x0McBin
EDK2_BUILD_DIR = $(EDK2_PLATFORM_NAME)-$(EDK2_ARCH)
EDK2_BUILD_ENV += DTC_PREFIX=$(HOST_DIR)/bin/
EDK2_BUILD_OPTS += -D INCLUDE_TFTP_COMMAND
EDK2_PACKAGES_PATHS += $(STAGING_DIR)/usr/share/edk2-non-osi

else ifeq ($(BR2_TARGET_EDK2_PLATFORM_QEMU_SBSA),y)
EDK2_ARCH = AARCH64
EDK2_DEPENDENCIES += arm-trusted-firmware
EDK2_PACKAGE_NAME = Platform/Qemu/SbsaQemu
EDK2_PLATFORM_NAME = SbsaQemu
EDK2_BUILD_DIR = $(EDK2_PLATFORM_NAME)
EDK2_PRE_BUILD_HOOKS += EDK2_PRE_BUILD_QEMU_SBSA

define EDK2_PRE_BUILD_QEMU_SBSA
	mkdir -p $(EDK2_BUILD_PACKAGES)/Platform/Qemu/Sbsa
	ln -srf $(BINARIES_DIR)/{bl1.bin,fip.bin} $(EDK2_BUILD_PACKAGES)/Platform/Qemu/Sbsa/
endef

endif

EDK2_BASETOOLS_OPTS = \
	EXTRA_LDFLAGS="$(HOST_LDFLAGS)" \
	EXTRA_OPTFLAGS="$(HOST_CPPFLAGS)"

EDK2_PACKAGES_PATH = $(subst $(space),:,$(strip $(EDK2_PACKAGES_PATHS)))

EDK2_BUILD_ENV += \
	WORKSPACE=$(@D) \
	PACKAGES_PATH=$(EDK2_PACKAGES_PATH) \
	PYTHON_COMMAND=$(HOST_DIR)/bin/python3 \
	IASL_PREFIX=$(HOST_DIR)/bin/ \
	NASM_PREFIX=$(HOST_DIR)/bin/ \
	GCC5_$(EDK2_ARCH)_PREFIX=$(TARGET_CROSS)

EDK2_BUILD_OPTS += \
	-t GCC5 \
	-n $(BR2_JLEVEL) \
	-a $(EDK2_ARCH) \
	-b $(EDK2_BUILD_TYPE) \
	-p $(EDK2_PACKAGE_NAME)/$(EDK2_PLATFORM_NAME).dsc

define EDK2_BUILD_CMDS
	mkdir -p $(EDK2_BUILD_PACKAGES)
	export $(EDK2_BUILD_ENV) && \
	unset ARCH && \
	source $(@D)/edksetup.sh && \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/BaseTools $(EDK2_BASETOOLS_OPTS) && \
	build $(EDK2_BUILD_OPTS) all
endef

define EDK2_INSTALL_IMAGES_CMDS
	cp -f $(@D)/Build/$(EDK2_BUILD_DIR)/$(EDK2_BUILD_TYPE)_GCC5/FV/*.fd $(BINARIES_DIR)
endef

$(eval $(generic-package))
