################################################################################
#
# bcm-refsw
#
################################################################################

ifeq ($(BR2_PACKAGE_BCM_REFSW_13_1),y)
BCM_REFSW_VERSION = 13.1
else ifeq ($(BR2_PACKAGE_BCM_REFSW_13_4),y)
BCM_REFSW_VERSION = 13.4-1
else ifeq ($(BR2_PACKAGE_BCM_REFSW_15_2),y)
BCM_REFSW_VERSION = 15.2
else ifeq ($(BR2_PACKAGE_BCM_REFSW_16_1),y)
BCM_REFSW_VERSION = 16.1-3
else ifeq ($(BR2_PACKAGE_BCM_REFSW_16_2),y)
BCM_REFSW_VERSION = 16.2-7
else ifeq ($(BR2_PACKAGE_BCM_REFSW_16_3),y)
BCM_REFSW_VERSION = 16.3-1
else ifeq ($(BR2_PACKAGE_BCM_REFSW_17_1),y)
BCM_REFSW_VERSION = 17.1-1
else ifeq ($(BR2_PACKAGE_BCM_REFSW_17_1_RDK),y)
BCM_REFSW_VERSION = 17.1-2
else ifeq ($(BR2_PACKAGE_BCM_REFSW_17_2),y)
BCM_REFSW_VERSION = 17.2-1
else ifeq ($(BR2_PACKAGE_BCM_REFSW_17_4),y)
BCM_REFSW_VERSION = 17.4-1
else
BCM_REFSW_VERSION = 16.2-7
endif

BCM_REFSW_SITE = git@github.com:Metrological/bcm-refsw.git
BCM_REFSW_SITE_METHOD = git

BCM_REFSW_DEPENDENCIES = linux host-pkgconf host-flex host-bison host-gperf
BCM_REFSW_LICENSE = PROPRIETARY
BCM_REFSW_INSTALL_STAGING = YES
BCM_REFSW_INSTALL_TARGET = YES

BCM_REFSW_PROVIDES = libegl libgles
ifeq ($(BR2_PACKAGE_WESTEROS),y)
	BCM_REFSW_DEPENDENCIES += wayland
endif

# SOC related info 
include package/bcm-refsw/platforms.inc

ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_14),y)
BCM_PMLIB_VERSION = 314
else
BCM_PMLIB_VERSION = 26
endif

BCM_REFSW_CONF_OPTS += \
	CROSS_COMPILE="${TARGET_CROSS}" \
	LINUX=${LINUX_DIR} \
	HOST_DIR="${HOST_DIR}"

BCM_REFSW_MAKE_ENV += \
	B_REFSW_ARCH=$(ARCH)-linux \
	B_REFSW_VERBOSE=y \
	B_REFSW_DEBUG_LEVEL=wrn \
	BCHP_VER=$(BCM_REFSW_PLATFORM_REV) \
	NEXUS_TOP="$(BCM_REFSW_DIR)/nexus" \
	NEXUS_PLATFORM=$(BCM_REFSW_PLATFORM) \
	NEXUS_MODE=proxy \
	NEXUS_HEADERS=y \
	NEXUS_EXTRA_CFLAGS="$(TARGET_CFLAGS) -Wno-error=undef" \
	NEXUS_EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
	VCX=$(BCM_REFSW_PLATFORM_VC) \
	V3D_EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
	V3D_EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
	NEXUS_IR_INPUT_EXTENSION_INC="${@D}/nexus/extensions/insert_ir_input/insert_ir_input.inc" \

ifeq ($(BR2_PACKAGE_BCM_REFSW_15_2),y)
BCM_REFSW_MAKE_ENV += CLIENT=y
else
BCM_REFSW_MAKE_ENV += NXCLIENT_SUPPORT=y
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE),y)
BCM_REFSW_MAKE_ENV += SAGE_SUPPORT=y
else
BCM_REFSW_MAKE_ENV += SAGE_SUPPORT=n
endif

ifeq ($(shell expr $(BCM_REFSW_VERSION) \>= 17.1),1)
BCM_REFSW_VCX = $(BCM_REFSW_DIR)/BSEAV/lib/gpu/${BCM_REFSW_PLATFORM_VC}
else
BCM_REFSW_VCX = $(BCM_REFSW_DIR)/rockford/middleware/${BCM_REFSW_PLATFORM_VC}
endif

BCM_REFSW_OUTPUT = $(BCM_REFSW_DIR)/obj.${BCM_REFSW_PLATFORM}
BCM_REFSW_BIN = ${BCM_REFSW_OUTPUT}/nexus/bin

ifneq ($(BR2_PACKAGE_WEBBRIDGE_PLUGIN_IRNEXUS_MODE),)
BCM_REFSW_IRMODE=$(call qstrip,$(BR2_PACKAGE_WEBBRIDGE_PLUGIN_IRNEXUS_MODE))
else
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IRNEXUS_MODE),)
BCM_REFSW_IRMODE=$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IRNEXUS_MODE))
else
BCM_REFSW_IRMODE=23
endif
endif

define BCM_REFSW_BUILD_NEXUS
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/nexus/build all \
			$(BCM_REFSW_BUILD_ADDITIONS)
endef

define BCM_REFSW_BUILD_VCX

	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C ${BCM_REFSW_VCX}/driver -f V3DDriver.mk \
			OBJDIR=${BCM_REFSW_OUTPUT}/rockford/middleware/v3d/driver/obj_${BCM_REFSW_PLATFORM}_release \
			LIBDIR=${BCM_REFSW_BIN}
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C ${BCM_REFSW_VCX}/platform/nexus -f platform_nexus.mk \
			OBJDIR=${BCM_REFSW_OUTPUT}/rockford/middleware/v3d/platform/obj_${BCM_REFSW_PLATFORM}_release \
			LIBDIR=${BCM_REFSW_BIN}
endef

define BCM_REFSW_BUILD_NXSERVER
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/nexus/nxclient/server all \
			LIBDIR=${BCM_REFSW_BIN}
endef

ifeq ($(BR2_PACKAGE_BCM_REFSW_NXCLIENT_EXAMPLES),y)
define BCM_REFSW_BUILD_NXCLIENT_EXAMPLES
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/nexus/nxclient/examples all \
			LIBDIR=${BCM_REFSW_BIN}
endef
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_PMLIB),y)
define BCM_REFSW_BUILD_PMLIB
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/BSEAV/lib/pmlib \
            LIBDIR=${BCM_REFSW_BIN}
endef
endif

ifeq ($(shell expr $(BCM_REFSW_VERSION) \>= 17.1),1)
BCM_CUBE_DIR = /BSEAV/lib/gpu/applications/nexus/cube
else
BCM_CUBE_DIR = /rockford/applications/khronos/v3d/nexus/cube
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_EGLCUBE),y)
define BCM_REFSW_BUILD_EGLCUBE
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
               $(MAKE) -C $(@D)/$(BCM_CUBE_DIR) \
			LIBDIR=${BCM_REFSW_BIN}
endef
endif


# wayland-egl is needed only for westeros
ifeq ($(BR2_PACKAGE_WESTEROS),y)
	include package/bcm-refsw/wayland-egl.inc
endif

define BCM_REFSW_INSTALL_LIBS
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnexus.so $1/usr/lib/libnexus.so
	$(INSTALL) -D $(BCM_REFSW_BIN)/libv3ddriver.so $1/usr/lib/libv3ddriver.so
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnxpl.so $1/usr/lib/libnxpl.so
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnxclient.so $1/usr/lib/libnxclient.so
	cd $1/usr/lib && ln -sf libv3ddriver.so libEGL.so && ln -sf libv3ddriver.so libGLESv2.so
endef

ifeq ($(BR2_PACKAGE_BCM_REFSW_PMLIB),y)
define BCM_REFSW_INSTALL_STAGING_PMLIB
	$(INSTALL) -m 644 -D $(BCM_REFSW_OUTPUT)/BSEAV/lib/pmlib/libpmlib.a $(STAGING_DIR)/usr/lib/libpmlib.a
	$(INSTALL) -m 644 $(BCM_REFSW_DIR)/BSEAV/lib/pmlib/$(BCM_PMLIB_VERSION)/pmlib.h $(STAGING_DIR)/usr/include/refsw
endef
endif

ifeq ($(BCM_REFSW_PLATFORM_VC),vc5)
define BCM_REFSW_INSTALL_EXTRA
	$(INSTALL) -D -m 755 package/bcm-refsw/S11wakeup $1/etc/init.d/S11wakeup
	$(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/wakeup_drv.ko $1/lib/modules/wakeup_drv.ko
endef
endif

define BCM_REFSW_INSTALL_STAGING_NXSERVER
	   $(INSTALL) -D $(BCM_REFSW_BIN)/libnxclient.so $1/usr/lib/libnxclient.so
endef

ifeq ($(BR2_PACKAGE_BCM_WESTON),y)
define BCM_REFSW_INSTALL_TARGET_NXSERVER_INIT
endef
else
define BCM_REFSW_INSTALL_TARGET_NXSERVER_INIT
	$(INSTALL) -D -m 755 package/bcm-refsw/S70nxserver $(TARGET_DIR)/etc/init.d/S70nxserver; \
	sed -i 's/%IRMODE%/${BCM_REFSW_IRMODE}/g' $(TARGET_DIR)/etc/init.d/S70nxserver;
endef
endif

define BCM_REFSW_INSTALL_TARGET_NXSERVER
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnxclient.so $(1)/usr/lib/libnxclient.so
	if [ "x$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR)" = "x" ]; then \
		$(INSTALL) -m 755 -D $(BCM_REFSW_BIN)/nxserver $(1)/usr/bin/nxserver; \
		$(BCM_REFSW_INSTALL_TARGET_NXSERVER_INIT) \
	fi
endef

define BCM_REFSW_BUILD_CMDS
	$(BCM_REFSW_BUILD_NEXUS)
	$(BCM_REFSW_BUILD_NXSERVER)
	$(BCM_REFSW_BUILD_NXCLIENT_EXAMPLES)
	$(BCM_REFSW_BUILD_PMLIB)
	$(BCM_REFSW_BUILD_VCX)
	$(BCM_REFSW_BUILD_EGLCUBE)
	$(BCM_REFSW_BUILD_WAYLAND_EGL)
endef

ifeq ($(BCM_REFSW_PLATFORM_VC),vc5) 
	ifeq ($(shell expr $(BCM_REFSW_VERSION) \>= 16.2),1)
        BCM_REFSW_VCX_KHRN = $(BCM_REFSW_VCX)/driver/libs/khrn/include
	else
		BCM_REFSW_VCX_KHRN = $(BCM_REFSW_VCX)/driver/interface/khronos/include
	endif
else
	BCM_REFSW_VCX_KHRN = $(BCM_REFSW_VCX)/driver/interface/khronos/include
endif

define BCM_REFSW_INSTALL_KHRONOS
	$(INSTALL) -m 644 ${BCM_REFSW_VCX_KHRN}/GLES/*.h $(STAGING_DIR)/usr/include/GLES/
	$(INSTALL) -m 644 ${BCM_REFSW_VCX_KHRN}/GLES2/*.h $(STAGING_DIR)/usr/include/GLES2/
	$(INSTALL) -m 644 ${BCM_REFSW_VCX_KHRN}/EGL/*.h $(STAGING_DIR)/usr/include/EGL/
	$(INSTALL) -m 644 ${BCM_REFSW_VCX_KHRN}/KHR/*.h $(STAGING_DIR)/usr/include/KHR/
endef

define BCM_REFSW_INSTALL_STAGING_CMDS
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib/pkgconfig
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/GLES
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/GLES2
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/EGL
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/KHR
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/refsw
	$(INSTALL) -m 644 package/bcm-refsw/${BCM_REFSW_PLATFORM_VC}/egl.pc $(STAGING_DIR)/usr/lib/pkgconfig/egl.pc
	$(INSTALL) -m 644 package/bcm-refsw/${BCM_REFSW_PLATFORM_VC}/glesv2.pc $(STAGING_DIR)/usr/lib/pkgconfig/
	$(INSTALL) -m 644 $(BCM_REFSW_BIN)/include/*.h $(STAGING_DIR)/usr/include/refsw/
	$(INSTALL) -m 644 $(BCM_REFSW_OUTPUT)/nexus/bin/include/*.h $(STAGING_DIR)/usr/include/refsw/
	$(INSTALL) -m 644 $(BCM_REFSW_DIR)/nexus/nxclient/server/*.h $(STAGING_DIR)/usr/include/refsw/
	$(INSTALL) -m 644 $(BCM_REFSW_BIN)/include/platform_app.inc $(STAGING_DIR)/usr/include/
	$(INSTALL) -m 644 ${BCM_REFSW_VCX}/platform/nexus/*.h $(STAGING_DIR)/usr/include/refsw/	
	$(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/libnxserver.a $(STAGING_DIR)/usr/lib/libnxserver.a
if [ $(shell expr $(BCM_REFSW_VERSION) \>= 17.1)$(shell expr $(BCM_REFSW_VERSION) \<= 17.2) = 11 ]; then \
	$(INSTALL) -m 644 $(BCM_REFSW_OUTPUT)/nexus/bin/nexus_kernel_include/*.h $(STAGING_DIR)/usr/include/refsw ; \
fi
	$(call BCM_REFSW_INSTALL_KHRONOS,$(STAGING_DIR))
	$(call BCM_REFSW_INSTALL_LIBS,$(STAGING_DIR))
	$(call BCM_REFSW_INSTALL_STAGING_NXSERVER,$(STAGING_DIR))
	$(call BCM_REFSW_INSTALL_STAGING_WAYLAND_EGL,$(STAGING_DIR))
	$(BCM_REFSW_INSTALL_STAGING_PMLIB)
endef

define BCM_REFSW_INSTALL_TARGET_CMDS
	$(INSTALL) -m 750 -D $(BCM_REFSW_BIN)/nexus $(TARGET_DIR)/sbin/nexus
	$(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/nexus.ko $(TARGET_DIR)/lib/modules/nexus.ko
	$(INSTALL) -D -m 755 package/bcm-refsw/S11nexus $(TARGET_DIR)/etc/init.d/S11nexus
	$(call BCM_REFSW_INSTALL_EXTRA,$(TARGET_DIR))
	$(call BCM_REFSW_INSTALL_LIBS,$(TARGET_DIR))
if [ $(shell expr $(BCM_REFSW_VERSION) \>= 17.1)$(shell expr $(BCM_REFSW_VERSION) \<= 17.2) = 11 ]; then \
	$(INSTALL) -m 644 $(BCM_REFSW_OUTPUT)/nexus/lib/b_os/libb_os.so $(TARGET_DIR)/usr/lib; \
fi
	$(call BCM_REFSW_INSTALL_TARGET_NXSERVER,$(TARGET_DIR))
	$(call BCM_REFSW_INSTALL_TARGET_EGLCUBE,$(TARGET_DIR))
	$(call BCM_REFSW_INSTALL_SAGE_BIN,$(TARGET_DIR))
	$(call BCM_REFSW_INSTALL_TARGET_WAYLAND_EGL,$(TARGET_DIR))
endef

$(eval $(generic-package))
