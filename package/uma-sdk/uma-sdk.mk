################################################################################
#
# uma-sdk
#
################################################################################
UMA_SDK_VERSION = 5e70f06a5b627deab51ca24580802dbe8e215f25
UMA_SDK_SITE = git@github.com:Metrological/SDK_UMA.git
UMA_SDK_SITE_METHOD = git
UMA_SDK_INSTALL_STAGING = YES
UMA_SDK_INSTALL_TARGET = YES

define UMA_SDK_INSTALL_STAGING_CMDS
	cp -Rpf $(@D)/usr/include/* $(STAGING_DIR)/usr/include/
	ln -sf $(STAGING_DIR)/usr/include/NOSPlayer/Player.h $(STAGING_DIR)/usr/include/Player.h
	cp -Rpf $(@D)/usr/lib/Player/* $(STAGING_DIR)/usr/lib/
	cp -Rpf $(@D)/usr/lib/Nagra/* $(STAGING_DIR)/usr/lib/
	cp -f $(@D)/qorvo/rf4ce.pc $(STAGING_DIR)/usr/lib/pkgconfig
	cp -f $(@D)/usr/lib/libGreenPeak.a $(STAGING_DIR)/usr/lib
	cp -f $(@D)/qorvo/code/Work/libBinShippedRefTarget_ZRC_MSO_GP501_BCM_RDK.a $(STAGING_DIR)/usr/lib
	mkdir -p $(STAGING_DIR)/usr/include/qorvo
	cp -Rpf $(@D)/qorvo/code/Applications $(STAGING_DIR)/usr/include/qorvo
	cp -Rpf $(@D)/qorvo/code/BaseComps $(STAGING_DIR)/usr/include/qorvo
endef

define UMA_SDK_INSTALL_TARGET_CMDS
	mkdir -p  $(TARGET_DIR)$(BR2_PACKAGE_BCM_REFSW_SAGE_PATH)
	mkdir -p  $(TARGET_DIR)/lib/modules/misc
	$(INSTALL) -m 0755 -D $(@D)/usr/lib/Player/* $(TARGET_DIR)/usr/lib/
	$(INSTALL) -m 0755 -D $(@D)/qorvo/gpK5.ko ${TARGET_DIR}/lib/modules/misc
	$(INSTALL) -D -m 0644 $(@D)/firmware/sage/* $(TARGET_DIR)/$(BR2_PACKAGE_BCM_REFSW_SAGE_PATH)/
endef

define QORVO_BUILD_MODULE
    CFLAGS = \
     -DGP501 \
     -DGP_USE_NEXUS_SPI \
     -nodefaultlibs \
     -Wno-unused-variable \
     -Wno-incompatible-pointer-types \
     -I$(STAGING_DIR)/usr/include \
     -I$(STAGING_DIR)/usr/include/linux \
     -I$(STAGING_DIR)/usr/include/refsw/ \
     -I$(STAGING_DIR)/usr/include/refsw/linuxkernel/include/ \
     -I${@D}/Driver/BCM97358Ref \
	 $(MAKE) -C $(LINUX_DIR) $(LINUX_MAKE_FLAGS) GP_CHIP=$(GREENPEAK_CHIP) EXTRA_CFLAGS="$(GREENPEAK_EXTRA_MOD_CFLAGS)" M=$(@D)/Driver modules
endef

define QORVO_INSTALL_MODULE
	$(MAKE) -C $(LINUX_DIR) $(LINUX_MAKE_FLAGS) M=$(@D)/Driver modules_install
endef

define UMA_SDK_BUILD_CMDS
	cd $(@D)/qorvo ; \
	SDKTARGETSYSROOT=${STAGING_DIR} \
        TOOLCHAIN=${HOST_DIR}/usr \
        TOOLCHAINBIN=${HOST_DIR}/usr/bin \
        CROSS_COMPILE="$(GNU_TARGET_NAME)-" \
	COMPILER=buildroot \
        INC=-I${STAGING_DIR}/usr/include \
        APPLIB=$(@D)/usr/lib/libGreenPeak.a \
        GP_VALIDATION_DISABLE=y \
        make applib ; \
	cd -
endef

$(eval $(generic-package))
