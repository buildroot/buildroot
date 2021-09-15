################################################################################
#
# xione-sdk
#
################################################################################
XIONE_SDK_VERSION = main
XIONE_SDK_SITE = git@github.com:Metrological/SDK_XiOne.git
XIONE_SDK_SITE_METHOD = git
XIONE_SDK_INSTALL_STAGING = YES
XIONE_SDK_INSTALL_TARGET = YES

define XIONE_SDK_INSTALL_STAGING_CMDS
	cp -Rpf $(@D)/mali/include/* $(STAGING_DIR)/usr/include/
	cp -Rpf $(@D)/mali/lib/* $(STAGING_DIR)/usr/lib/
endef

define XIONE_SDK_INSTALL_TARGET_CMDS
	cp -pf $(@D)/mali/lib/*.so $(STAGING_DIR)/usr/lib/
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

$(eval $(generic-package))
