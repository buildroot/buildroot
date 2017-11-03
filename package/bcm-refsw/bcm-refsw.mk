################################################################################
#
# bcm-refsw
#
################################################################################

ifeq ($(BR2_PACKAGE_BCM_REFSW_13_1),y)
BCM_REFSW_VERSION = 13.1
else ifeq ($(BR2_PACKAGE_BCM_REFSW_13_4),y)
BCM_REFSW_VERSION = 13.4-1
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
else ifeq ($(BR2_PACKAGE_BCM_REFSW_15_2),y)
BCM_REFSW_VERSION = 15.2
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

ifeq ($(BR2_arm),y)
ifeq ($(BR2_PACKAGE_BCM_REFSW_PLATFORM_7437),y)
BCM_REFSW_PLATFORM = 974371
BCM_REFSW_PLATFORM_VC = v3d
BCM_REFSW_PLATFORM_REV = A0
BCM_REFSW_BCHP_CHIP = 7437
BCM_REFSW_BCHP_VER_LOWER = a0
BCM_REFSW_MAKE_ENV += \
	NEXUS_USE_74371_XID="y"
else ifeq ($(BR2_PACKAGE_BCM_REFSW_PLATFORM_7271),y)
BCM_REFSW_PLATFORM = 97271
BCM_REFSW_PLATFORM_REV = B0
BCM_REFSW_PLATFORM_VC = vc5
BCM_REFSW_BCHP_CHIP = 7271
BCM_REFSW_BCHP_VER_LOWER = b0
else ifeq ($(BR2_PACKAGE_BCM_REFSW_PLATFORM_72604),y)
BCM_REFSW_PLATFORM = 97260
BCM_REFSW_PLATFORM_REV = A0
BCM_REFSW_PLATFORM_VC = vc5
BCM_REFSW_BCHP_VER_LOWER = a0
else ifeq ($(BR2_PACKAGE_BCM_REFSW_PLATFORM_7250),y)
BCM_REFSW_PLATFORM = 97250
BCM_REFSW_PLATFORM_REV = B0
BCM_REFSW_PLATFORM_VC = vc5
BCM_REFSW_BCHP_CHIP = 7250
BCM_REFSW_BCHP_VER_LOWER = b0
BCM_REFSW_MAKE_ENV += NEXUS_USE_7250_SV=y
else
BCM_REFSW_PLATFORM = 97439
BCM_REFSW_PLATFORM_REV = B0
BCM_REFSW_MAKE_ENV += NEXUS_USE_7439_SFF=y
BCM_REFSW_PLATFORM_VC = vc5
BCM_REFSW_BCHP_CHIP = 7439
BCM_REFSW_BCHP_VER_LOWER = b0
endif
BCM_REFSW_MAKE_ENV += \
	NEXUS_ENDIAN=BSTD_ENDIAN_LITTLE
else ifeq ($(BR2_mipsel),y)
ifeq ($(BR2_PACKAGE_BCM_REFSW_PLATFORM_7425),y)
BCM_REFSW_PLATFORM = 97425
BCM_REFSW_PLATFORM_REV = B2
BCM_REFSW_MAKE_ENV += \
	NEXUS_USE_7425_VMS_SFF=y \
	NEXUS_USE_FRONTEND_DAUGHTER_CARD=y
else ifeq ($(BR2_PACKAGE_BCM_REFSW_PLATFORM_7428),y)
BCM_REFSW_PLATFORM = 97428
BCM_REFSW_PLATFORM_REV = B0
else ifeq ($(BR2_PACKAGE_BCM_REFSW_PLATFORM_7429),y)
BCM_REFSW_PLATFORM = 97429
BCM_REFSW_PLATFORM_REV = B0
else
BCM_REFSW_PLATFORM = 97429
BCM_REFSW_PLATFORM_REV = B0
endif
BCM_REFSW_PLATFORM_VC = v3d
BCM_REFSW_MAKE_ENV += NEXUS_ENDIAN=BSTD_ENDIAN_BIG
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
WAYLAND_EGL_DIR=${BCM_REFSW_VCX}/platform/wayland/
define BCM_REFSW_BUILD_WAYLAND_EGL
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(WAYLAND_EGL_DIR) -f wayland_nexus_protocol.mk \
	        WAYLAND_SCANNER=${HOST_DIR}/usr/bin/wayland-scanner \
			APPLIBS_TARGET_LIB_DIR=${BCM_REFSW_BIN} \
			APPLIBS_TARGET_INC_DIR=${BCM_REFSW_BIN}/include
			
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(WAYLAND_EGL_DIR) -f wayland_egl.mk \
	        WAYLAND_SCANNER=${HOST_DIR}/usr/bin/wayland-scanner \
			APPLIBS_TARGET_LIB_DIR=${BCM_REFSW_BIN} \
			APPLIBS_TARGET_INC_DIR=${BCM_REFSW_BIN}/include
			
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(WAYLAND_EGL_DIR) -f platform_wayland_server.mk \
	        WAYLAND_SCANNER=${HOST_DIR}/usr/bin/wayland-scanner \
			APPLIBS_TARGET_LIB_DIR=${BCM_REFSW_BIN} \
			APPLIBS_TARGET_INC_DIR=${BCM_REFSW_BIN}/include
			
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(WAYLAND_EGL_DIR) -f platform_wayland_client.mk \
	        WAYLAND_SCANNER=${HOST_DIR}/usr/bin/wayland-scanner \
			APPLIBS_TARGET_LIB_DIR=${BCM_REFSW_BIN} \
			APPLIBS_TARGET_INC_DIR=${BCM_REFSW_BIN}/include
endef

ifeq ($(BCM_REFSW_PLATFORM_VC),vc5)
define BCM_REFSW_INSTALL_STAGING_WAYLAND_EGL_GPU
		    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/interface/khronos/include/
		    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/interface/khronos/include/bcg_abstract/
		    
			ln -sf ../../../EGL $(STAGING_DIR)/usr/include/interface/khronos/include/
			ln -sf ../../../GLES $(STAGING_DIR)/usr/include/interface/khronos/include/
			ln -sf ../../../GLES2 $(STAGING_DIR)/usr/include/interface/khronos/include/
			ln -sf ../helpers $(STAGING_DIR)/usr/include/interface/khronos/include/
			
		    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/nexus/*.h $(STAGING_DIR)/usr/include/interface/khronos/include
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/khrn/egl/platform/bcg_abstract/*.h $(STAGING_DIR)/usr/include/interface/khronos/include/bcg_abstract
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/bcg_abstract/*.h $(STAGING_DIR)/usr/include/interface/khronos/include/bcg_abstract
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/*.h $(STAGING_DIR)/usr/include/interface/khronos/include
			
			$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/vcos
		    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/vcos/include
		    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/vcos/posix
	    	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/vcos/gcc
		
			$(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/core/vcos/include/*.h $(STAGING_DIR)/usr/include/vcos/include
			$(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/core/vcos/posix/*.h $(STAGING_DIR)/usr/include/vcos/posix
			$(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/core/vcos/gcc/*.h $(STAGING_DIR)/usr/include/vcos/gcc
			
			$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/libs
			$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/libs/util
			$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/libs/util/log
			$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/libs/core
			$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/libs/core/v3d
			
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/util/*.h $(STAGING_DIR)/usr/include/libs/util
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/util/log/*.h $(STAGING_DIR)/usr/include/libs/util/log
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/core/v3d/*.h $(STAGING_DIR)/usr/include/libs/core/v3d
			
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/gmem.inl $(STAGING_DIR)/usr/include/interface/khronos/include
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/bcg_abstract/gmem_plat.inl $(STAGING_DIR)/usr/include/interface/khronos/include
			
			#$(INSTALL) the c file for wayland-egl building usage.
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/nexus/display_nexus.c $(STAGING_DIR)/usr/share/wayland-egl
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/nexus/*.c             $(STAGING_DIR)/usr/share/wayland-egl/nexus
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/nexus/*.h             $(STAGING_DIR)/usr/share/wayland-egl/nexus
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/common/*.c            $(STAGING_DIR)/usr/share/wayland-egl/common
			$(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/common/*.h            $(STAGING_DIR)/usr/share/wayland-egl/common

			if [ -e $(@D)/trellis/display/weston/include/EGL/eglext.h ]; then \
				$(INSTALL) -m 0755 $(@D)/trellis/display/weston/include/EGL/eglext.h        $(STAGING_DIR)/usr/include/EGL; \
				$(INSTALL) -m 0755 $(@D)/trellis/display/weston/include/EGL/eglext_brcm.h   $(STAGING_DIR)/usr/include/EGL; \
			fi
			if [ -e $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_common.h ]; then \
				$(INSTALL) -m 0755 $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_common.h        $(STAGING_DIR)/usr/include; \
			fi
			if [ -e $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_v3d_hub_ctl.h ]; then \
				$(INSTALL) -m 0755 $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_v3d_hub_ctl.h        $(STAGING_DIR)/usr/include; \
			fi
endef
else
define BCM_REFSW_INSTALL_STAGING_WAYLAND_EGL_GPU
     #$(INSTALL) the c file for wayland-egl building usage.
    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/v3d/platform/nexus/*.c             $(STAGING_DIR)/usr/share/wayland-egl/nexus
    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/v3d/platform/common/*.c            $(STAGING_DIR)/usr/share/wayland-egl/common
    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/v3d/platform/nexus/*.h             $(STAGING_DIR)/usr/share/wayland-egl
    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/v3d/platform/common/*.h            $(STAGING_DIR)/usr/share/wayland-egl
endef
endif

define BCM_REFSW_INSTALL_STAGING_WAYLAND_EGL
	$(INSTALL) -m 644 -D $(WAYLAND_EGL_DIR)/lib_${BCM_REFSW_PLATFORM}_release/*.so $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 644 -D $(WAYLAND_EGL_DIR)/lib_${BCM_REFSW_PLATFORM}_release/libbcm_wayland_egl.so $(STAGING_DIR)/usr/lib/libwayland-egl.so
	$(INSTALL) -m 644 package/bcm-refsw/${BCM_REFSW_PLATFORM_VC}/wayland-egl.pc $(STAGING_DIR)/usr/lib/pkgconfig/
	$(INSTALL) -m 644 $(WAYLAND_EGL_DIR)/autogen/*.h $(STAGING_DIR)/usr/include/refsw/
		
	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share
	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share/wayland-egl
	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share/wayland-egl/common
	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share/wayland-egl/nexus
		
	$(call BCM_REFSW_INSTALL_STAGING_WAYLAND_EGL_GPU,$(STAGING_DIR))
			
    #$(INSTALL) the c file for wayland-egl, cube/earth_es2 building usage.
    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/nxclient
    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share/wayland-egl/common
    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share/wayland-egl/cube
    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share/wayland-egl/earth_es2
    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/bin/textures
    $(INSTALL) -m 0644 $(@D)/nexus/nxclient/server/*.h                                    $(STAGING_DIR)/usr/include/nxclient
    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/applications/nexus/common/*             $(STAGING_DIR)/usr/share/wayland-egl/common
    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/applications/nexus/cube/cube.c          $(STAGING_DIR)/usr/share/wayland-egl/cube
    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/applications/nexus/earth_es2/*.c         $(STAGING_DIR)/usr/share/wayland-egl/earth_es2
    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/applications/nexus/earth_es2/*.h         $(STAGING_DIR)/usr/share/wayland-egl/earth_es2
    $(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/applications/nexus/earth_es2/textures/* $(STAGING_DIR)/usr/bin/textures

    $(INSTALL) -m 0755 $(@D)/BSEAV/lib/utils/*.h $(STAGING_DIR)/usr/include
		
    $(INSTALL) -m 0644 $(@D)/rockford/lib/psip/include/*.h $(STAGING_DIR)/usr/include
    $(INSTALL) -m 0644 $(@D)/nexus/lib/playback_ip/include/*.h $(STAGING_DIR)/usr/include
    $(INSTALL) -m 0644 $(@D)/BSEAV/lib/tshdrbuilder/*.h $(STAGING_DIR)/usr/include
endef

define BCM_REFSW_INSTALL_TARGET_WAYLAND_EGL
	$(INSTALL) -m 644 -D $(WAYLAND_EGL_DIR)/lib_${BCM_REFSW_PLATFORM}_release/*.so $(TARGET_DIR)/usr/lib
endef
endif

define BCM_REFSW_INSTALL_LIBS
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnexus.so $1/usr/lib/libnexus.so
	$(INSTALL) -D $(BCM_REFSW_BIN)/libv3ddriver.so $1/usr/lib/libv3ddriver.so
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnxpl.so $1/usr/lib/libnxpl.so
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnxclient.so $1/usr/lib/libnxclient.so
	cd $1/usr/lib && ln -sf libv3ddriver.so libEGL.so && ln -sf libv3ddriver.so libGLESv2.so
endef

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
if [ $(shell expr $(BCM_REFSW_VERSION) \>= 17.1) = 1 ]; then \
	$(INSTALL) -m 644 $(BCM_REFSW_OUTPUT)/nexus/bin/nexus_kernel_include/*.h $(STAGING_DIR)/usr/include/refsw ; \
fi
	$(call BCM_REFSW_INSTALL_KHRONOS,$(STAGING_DIR))
	$(call BCM_REFSW_INSTALL_LIBS,$(STAGING_DIR))
	$(call BCM_REFSW_INSTALL_STAGING_NXSERVER,$(STAGING_DIR))
	$(call BCM_REFSW_INSTALL_STAGING_WAYLAND_EGL,$(STAGING_DIR))
	
endef

define BCM_REFSW_INSTALL_TARGET_CMDS
	$(INSTALL) -m 750 -D $(BCM_REFSW_BIN)/nexus $(TARGET_DIR)/sbin/nexus
	$(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/nexus.ko $(TARGET_DIR)/lib/modules/nexus.ko
	$(INSTALL) -D -m 755 package/bcm-refsw/S11nexus $(TARGET_DIR)/etc/init.d/S11nexus
	$(call BCM_REFSW_INSTALL_EXTRA,$(TARGET_DIR))
	$(call BCM_REFSW_INSTALL_LIBS,$(TARGET_DIR))
if [ $(shell expr $(BCM_REFSW_VERSION) \>= 17.1) = 1 ]; then \
	$(INSTALL) -m 644 $(BCM_REFSW_OUTPUT)/nexus/lib/b_os/libb_os.so $(TARGET_DIR)/usr/lib; \
fi
	$(call BCM_REFSW_INSTALL_TARGET_NXSERVER,$(TARGET_DIR))
	$(call BCM_REFSW_INSTALL_TARGET_EGLCUBE,$(TARGET_DIR))
	$(call BCM_REFSW_INSTALL_SAGE_BIN,$(TARGET_DIR))
	$(call BCM_REFSW_INSTALL_TARGET_WAYLAND_EGL,$(TARGET_DIR))
	
endef

$(eval $(generic-package))

