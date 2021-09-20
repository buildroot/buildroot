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

define XIONE_SDK_DEVICES
        /dev/console c  622  0  0  5  1  0  0  -
        /dev/ptmx    c  622  0  0  5  2  0  0  -
        /dev/tty     c  622  0  0  5  0  0  0  -
        /dev/tty0    c  622  0  0  4  0  0  0  -
        /dev/tty1    c  622  0  0  4  0  0  0  -
        /dev/tty2    c  622  0  0  4  0  0  0  -
        /dev/ttyS0   c  622  0  0  5  3  0  0  -
        /dev/random  c  622  0  0  1  8  0  0  -
        /dev/random  c  622  0  0  1  9  0  0  -
endef

define XIONE_SDK_PERMISSIONS
endef

define XIONE_SDK_INSTALL_TARGET_CMDS
	cp -pf $(@D)/mali/lib/*.so $(STAGING_DIR)/usr/lib/
	cp -pf $(@D)/mali/lib/*.so $(STAGING_DIR)/usr/lib/
	cp -pf $(@D)/verity/* board/xione
	cp -pf $(@D)/image/* board/xione
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
