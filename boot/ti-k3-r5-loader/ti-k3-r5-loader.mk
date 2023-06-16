################################################################################
#
# ti-k3-r5-loader
#
################################################################################

TI_K3_R5_LOADER_VERSION = $(call qstrip,$(BR2_TARGET_TI_K3_R5_LOADER_VERSION))

ifeq ($(BR2_TARGET_TI_K3_R5_LOADER_CUSTOM_TARBALL),y)
# Handle custom U-Boot tarballs as specified by the configuration
TI_K3_R5_LOADER_TARBALL = $(call qstrip,$(BR2_TARGET_TI_K3_R5_LOADER_CUSTOM_TARBALL_LOCATION))
TI_K3_R5_LOADER_SITE = $(patsubst %/,%,$(dir $(TI_K3_R5_LOADER_TARBALL)))
TI_K3_R5_LOADER_SOURCE = $(notdir $(TI_K3_R5_LOADER_TARBALL))
else ifeq ($(BR2_TARGET_TI_K3_R5_LOADER_CUSTOM_GIT),y)
TI_K3_R5_LOADER_SITE = $(call qstrip,$(BR2_TARGET_TI_K3_R5_LOADER_CUSTOM_REPO_URL))
TI_K3_R5_LOADER_SITE_METHOD = git
else ifeq ($(BR2_TARGET_TI_K3_R5_LOADER_CUSTOM_HG),y)
TI_K3_R5_LOADER_SITE = $(call qstrip,$(BR2_TARGET_TI_K3_R5_LOADER_CUSTOM_REPO_URL))
TI_K3_R5_LOADER_SITE_METHOD = hg
else ifeq ($(BR2_TARGET_TI_K3_R5_LOADER_CUSTOM_SVN),y)
TI_K3_R5_LOADER_SITE = $(call qstrip,$(BR2_TARGET_TI_K3_R5_LOADER_CUSTOM_REPO_URL))
TI_K3_R5_LOADER_SITE_METHOD = svn
else
# Handle stable official U-Boot versions
TI_K3_R5_LOADER_SITE = https://ftp.denx.de/pub/u-boot
TI_K3_R5_LOADER_SOURCE = u-boot-$(TI_K3_R5_LOADER_VERSION).tar.bz2
endif

ifeq ($(BR2_TARGET_TI_K3_R5_LOADER)$(BR2_TARGET_TI_K3_R5_LOADER_LATEST_VERSION),y)
BR_NO_CHECK_HASH_FOR += $(TI_K3_R5_LOADER_SOURCE)
endif

TI_K3_R5_LOADER_LICENSE = GPL-2.0+
TI_K3_R5_LOADER_LICENSE_FILES = Licenses/gpl-2.0.txt
TI_K3_R5_LOADER_CPE_ID_VENDOR = denx
TI_K3_R5_LOADER_CPE_ID_PRODUCT = u-boot
TI_K3_R5_LOADER_INSTALL_IMAGES = YES
TI_K3_R5_LOADER_DEPENDENCIES = \
	host-pkgconf \
	$(BR2_MAKE_HOST_DEPENDENCY) \
	host-arm-gnu-toolchain \
	host-openssl

TI_K3_R5_LOADER_MAKE = $(BR2_MAKE)
TI_K3_R5_LOADER_MAKE_ENV = $(TARGET_MAKE_ENV)
TI_K3_R5_LOADER_KCONFIG_DEPENDENCIES = \
	host-arm-gnu-toolchain \
	$(BR2_MAKE_HOST_DEPENDENCY) \
	$(BR2_BISON_HOST_DEPENDENCY) \
	$(BR2_FLEX_HOST_DEPENDENCY)

ifeq ($(BR2_TARGET_TI_K3_R5_LOADER_USE_DEFCONFIG),y)
TI_K3_R5_LOADER_KCONFIG_DEFCONFIG = $(call qstrip,$(BR2_TARGET_TI_K3_R5_LOADER_BOARD_DEFCONFIG))_defconfig
else ifeq ($(BR2_TARGET_TI_K3_R5_LOADER_USE_CUSTOM_CONFIG),y)
TI_K3_R5_LOADER_KCONFIG_FILE = $(call qstrip,$(BR2_TARGET_TI_K3_R5_LOADER_CUSTOM_CONFIG_FILE))
endif # BR2_TARGET_TI_K3_R5_LOADER_USE_DEFCONFIG
TI_K3_R5_LOADER_MAKE_OPTS = \
	CROSS_COMPILE=$(HOST_DIR)/bin/arm-none-eabi- \
	ARCH=arm \
	HOSTCC="$(HOSTCC) $(subst -I/,-isystem /,$(subst -I /,-isystem /,$(HOST_CFLAGS)))" \
	HOSTLDFLAGS="$(HOST_LDFLAGS)"

define TI_K3_R5_LOADER_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(TI_K3_R5_LOADER_MAKE) -C $(@D) $(TI_K3_R5_LOADER_MAKE_OPTS)
endef

define TI_K3_R5_LOADER_INSTALL_IMAGES_CMDS
	cp $(@D)/spl/u-boot-spl.bin $(BINARIES_DIR)/r5-u-boot-spl.bin
endef

$(eval $(kconfig-package))
