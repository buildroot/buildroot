################################################################################
#
# greenpeak rf4ce
#
################################################################################
GREENPEAK_CHIP = $(call qstrip,$(BR2_PACKAGE_GREENPEAK_TYPE))
GREENPEAK_SITE_METHOD = git
GREENPEAK_SITE = git@github.com:Metrological/greenpeak.git
GREENPEAK_DEPENDENCIES = linux
GREENPEAK_INSTALL_STAGING = YES
GREENPEAK_REPO_VERSION = 1.0

ifeq ($(BR2_PACKAGE_GREENPEAK),y)
ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
  GREENPEAK_PLATFORM = brcm
else ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
  GREENPEAK_PLATFORM = rpi
else
  $(error "Chosen platform is not supported.")
endif

ifneq (,$(findstring $(GREENPEAK_CHIP), GP501 GP510 GP711))
  GREENPEAK_CHIP_REPO = gp501
  GREENPEAK_REPO_VERSION = 1.1
else ifneq (,$(findstring $(GREENPEAK_CHIP), GP502 GP712))
  GREENPEAK_CHIP_REPO = gp712
else ifneq (,$(findstring $(GREENPEAK_CHIP), ZD4500ZNO))
  GREENPEAK_CHIP_REPO = zd4500zno
  GREENPEAK_CHIP = GP501
  GREENPEAK_REPO_VERSION = 1.1
else
  $(error "Chip ${GREENPEAK_CHIP} is not supported.")
endif
endif

GREENPEAK_VERSION = ${GREENPEAK_CHIP_REPO}_${GREENPEAK_PLATFORM}_${ARCH}_${GREENPEAK_REPO_VERSION}

ifeq ($(BR2_PACKAGE_GREENPEAK_KERNEL_MODULE),y)
GREENPEAK_EXTRA_MOD_CFLAGS = \
     -D$(GREENPEAK_CHIP) \
     -I$(STAGING_DIR)/usr/include 

ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
GREENPEAK_EXTRA_MOD_CFLAGS += \
     -I$(STAGING_DIR)/usr/include/refsw/linuxkernel/include/ \
     -DGP_USE_NEXUS_SPI \
     -nodefaultlibs \
     -I${@D}/Driver/BCM97358Ref 

define GREENPEAK_PREPARE_MODULE
	$(INSTALL) -m 644 -D $(STAGING_DIR)/usr/include/refsw/linuxkernel/Module.symvers ${@D}/Driver/
	$(INSTALL) -m 775 -D $(STAGING_DIR)/usr/include/refsw/linuxkernel/libnexus_driver.a ${@D}/Driver/
endef
endif

define GREENPEAK_BUILD_MODULE
	 $(GREENPEAK_PREPARE_MODULE)
	 $(MAKE) -C $(LINUX_DIR) $(LINUX_MAKE_FLAGS) GP_CHIP=$(GREENPEAK_CHIP) EXTRA_CFLAGS="$(GREENPEAK_EXTRA_MOD_CFLAGS)" M=$(@D)/Driver modules
endef

define GREENPEAK_INSTALL_MODULE
	$(MAKE) -C $(LINUX_DIR) $(LINUX_MAKE_FLAGS) M=$(@D)/Driver modules_install
endef
endif

ifeq ($(BR2_PACKAGE_GREENPEAK_LIB),y)
GREENPEAK_EXTRA_CFLAGS = \
	-std=gnu99 \
	-fomit-frame-pointer \
	-fno-strict-aliasing \
	-fPIC \
	-ffreestanding \
	-DGP_NVM_PATH=/root/gp \
	-DGP_NVM_FILENAME=/root/gp/gpNvm.dat \
	-DGP_DEVICE_PATH=${BR2_PACKAGE_GREENPEAK_DEVICE_NODE_PATH}

GREENPEAK_OPTIONS = \
	TOOLCHAINBIN="$(HOST_DIR)/usr/bin" \
	TOOLCHAIN="$(HOST_DIR)/usr" \
	CROSS_COMPILE="$(GNU_TARGET_NAME)-" \
	CFLAGS_COMPILER="$(TARGET_CFLAGS) $(GREENPEAK_EXTRA_CFLAGS)"

define GREENPEAK_BUILD_LIB
    $(info "Building RF4CE lib")
	$(MAKE1) -C $(@D)/Stack clean
	COMPILER=buildroot $(TARGET_MAKE_ENV) $(MAKE1) ${GREENPEAK_OPTIONS} -C $(@D)/Stack archive
endef

define GREENPEAK_INSTALL_LIB_DEV
    $(INSTALL) -m 755 -d $(1)/usr/include/qorvo
    cp -a $(@D)/Stack/Work/bin/include/* $(1)/usr/include/qorvo
    $(INSTALL) -m 750 -D $(@D)/Stack/Work/bin/qorvo-rf4ce.pc $(1)/usr/lib/pkgconfig/rf4ce.pc
    $(INSTALL) -m 750 -D $(@D)/Stack/Work/bin/*.a $(1)/usr/lib
endef
endif

define GREENPEAK_INSTALL_STAGING_CMDS
	$(call GREENPEAK_INSTALL_LIB_DEV, $(STAGING_DIR))
endef

define GREENPEAK_INSTALL_TARGET_CMDS
    $(call GREENPEAK_INSTALL_MODULE)
endef

define GREENPEAK_BUILD_CMDS
    $(call GREENPEAK_BUILD_MODULE)
    $(call GREENPEAK_BUILD_LIB)
endef

$(eval $(generic-package))
