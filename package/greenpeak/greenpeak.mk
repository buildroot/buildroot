################################################################################
#
# greenpeak rf4ce
#
################################################################################
GREENPEAK_VERSION = 63da7153b7d484b877b7b22bec6c5b32fc4c9da9
GREENPEAK_SITE_METHOD = git
GREENPEAK_SITE = git@github.com:Metrological/greenpeak.git
GREENPEAK_DEPENDENCIES = linux rpi-firmware

GREENPEAK_CHIP = $(call qstrip,$(BR2_PACKAGE_GREENPEAK_TYPE))

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE),y)
GREENPEAK_DEPENDENCIES += rpi-firmware
endif

ifeq ($(BR2_PACKAGE_GREENPEAK_USERLANDLIB),y)
GREENPEAK_ARTIFACT = libRf4ce.a
GREENPEAK_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE),y)
define GREENPEAK_INSTALL_DTS
	$(INSTALL) -D -m 0644 $(@D)/devicetree/gp501.dtbo $(BINARIES_DIR)/rpi-firmware/overlays/
endef
endif

define GREENPEAK_INSTALL_STAGING_CMDS
	$(INSTALL) -d -m 755 $(STAGING_DIR)/usr/include/greenpeak
	$(INSTALL) -D -m 0644 $(@D)/ZRCTarget_GP501_RPi/libRf4ce.a $(STAGING_DIR)/usr/lib/ 
	$(INSTALL) -D -m 0644 $(@D)/ZRCTarget_GP501_RPi/code/Work/ZRCTarget_GP501_RPi/libZRCTarget_GP501_RPi.a $(STAGING_DIR)/usr/lib/libGP501.a
	$(INSTALL) -D package/greenpeak/rf4ce.pc $(STAGING_DIR)/usr/lib/pkgconfig/rf4ce.pc
	cp -r $(@D)/ZRCTarget_GP501_RPi/code/BaseComps/v2.4.5.2/comps/* $(STAGING_DIR)/usr/include/greenpeak;
    cp -r $(@D)/ZRCTarget_GP501_RPi/code/BaseComps/v2.4.5.2/inc/* $(STAGING_DIR)/usr/include/greenpeak; 
endef

define GREENPEAK_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 package/greenpeak/S40greenpeak $(TARGET_DIR)/etc/init.d
	$(GREENPEAK_INSTALL_MODULE)
	$(GREENPEAK_INSTALL_DTS)
	$(GREENPEAK_INSTALL_UEI_REF)
	$(GREENPEAK_INSTALL_GREENPEAK_RPI_FIRMWARE)
endef

else

GREENPEAK_ARTIFACT = "GP_APPLICATION=1"

define GREENPEAK_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/ZRCTarget_GP501_RPi/Work/ZRCTarget_GP501_RPi.elf $(TARGET_DIR)/usr/bin/zrc
	$(INSTALL) -D -m 0755 package/greenpeak/S40greenpeak $(TARGET_DIR)/etc/init.d
	$(GREENPEAK_INSTALL_MODULE)
	$(GREENPEAK_INSTALL_GREENPEAK_RPI_FIRMWARE)
endef
endif

GREENPEAK_EXTRA_CFLAGS = \
	-std=gnu99 \
	-fomit-frame-pointer \
	-fno-strict-aliasing \
	-fPIC \
	-ffreestanding \
	-DGP_NVM_PATH=/root/gp \
	-DGP_NVM_FILENAME=/root/gp/gpNvm.dat 
    
GREENPEAK_EXTRA_MOD_CFLAGS = \
     -D$(GREENPEAK_CHIP) \
     -I$(@D)/driver/RPi_3_2_27 \
     
define GREENPEAK_BUILD_MODULE
	 $(MAKE) -C $(LINUX_DIR) $(LINUX_MAKE_FLAGS) GP_CHIP=$(GREENPEAK_CHIP) EXTRA_CFLAGS="$(GREENPEAK_EXTRA_MOD_CFLAGS)" M=$(@D)/driver modules
endef

define GREENPEAK_INSTALL_MODULE
	$(MAKE) -C $(LINUX_DIR) $(LINUX_MAKE_FLAGS) M=$(@D)/driver modules_install
endef

ifeq ($(BR2_PACKAGE_GREENPEAK_RPI_FIRMWARE),y)
define GREENPEAK_INSTALL_GREENPEAK_RPI_FIRMWARE
	$(INSTALL) -D -m 0644 $(@D)/rpi-firmware/start.elf $(BINARIES_DIR)/gp-rpi-firmware/start.elf
	$(INSTALL) -D -m 0644 $(@D)/rpi-firmware/fixup.dat $(BINARIES_DIR)/gp-rpi-firmware/fixup.dat
	$(INSTALL) -D -m 0644 $(@D)/rpi-firmware/config.txt $(BINARIES_DIR)/gp-rpi-firmware/config.txt
endef
endif

ifeq ($(BR2_PACKAGE_GREENPEAK_TEST_TOOLS),y)  
define GREENPEAK_BUILD_UEI_REF
    COMPILER=buildroot $(TARGET_MAKE_ENV) $(MAKE1) TOOLCHAIN="$(HOST_DIR)/usr" CROSS_COMPILE="$(GNU_TARGET_NAME)-" CFLAGS_COMPILER="$(TARGET_CFLAGS) $(GREENPEAK_EXTRA_CFLAGS)" -C $(@D)/testapp all
	COMPILER=buildroot $(TARGET_MAKE_ENV) $(MAKE1) TOOLCHAIN="$(HOST_DIR)/usr" CROSS_COMPILE="$(GNU_TARGET_NAME)-" CFLAGS_COMPILER="$(TARGET_CFLAGS) $(GREENPEAK_EXTRA_CFLAGS)" -C $(@D)/RefTarget_ZRC_MSO_$(GREENPEAK_CHIP)_RPi all
	COMPILER=buildroot $(TARGET_MAKE_ENV) $(MAKE1) TOOLCHAIN="$(HOST_DIR)/usr" CROSS_COMPILE="$(GNU_TARGET_NAME)-" CFLAGS_COMPILER="$(TARGET_CFLAGS) $(GREENPEAK_EXTRA_CFLAGS)" -C $(@D)/ZRCTarget_$(GREENPEAK_CHIP)_RPi "GP_APPLICATION=1"
endef
define GREENPEAK_INSTALL_UEI_REF
    $(INSTALL) -D -m 0755 $(@D)/RefTarget_ZRC_MSO_$(GREENPEAK_CHIP)_RPi/Work/RefTarget_ZRC_MSO_GP501_RPi.elf $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/ZRCTarget_GP501_RPi/Work/ZRCTarget_GP501_RPi.elf $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/testapp/work/TestKernelDriver_GP501_RPi.elf $(TARGET_DIR)/usr/bin
endef
endif

define GREENPEAK_BUILD_CMDS
	COMPILER=buildroot $(TARGET_MAKE_ENV) $(MAKE1) TOOLCHAIN="$(HOST_DIR)/usr" CROSS_COMPILE="$(GNU_TARGET_NAME)-" CFLAGS_COMPILER="$(TARGET_CFLAGS) $(GREENPEAK_EXTRA_CFLAGS)" -C $(@D)/ZRCTarget_$(GREENPEAK_CHIP)_RPi ${GREENPEAK_ARTIFACT}
	$(GREENPEAK_BUILD_MODULE)
	$(GREENPEAK_BUILD_UEI_REF)
endef

$(eval $(generic-package))
