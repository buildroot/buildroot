WAYLAND_EGL_DIR=${BCM_REFSW_VCX}/platform/wayland/
define BCM_REFSW_BUILD_WAYLAND_EGL
if [ $(shell expr $(BCM_REFSW_VERSION) \< 19.1) = 1 ]; then \
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(WAYLAND_EGL_DIR) -f wayland_nexus_protocol.mk \
             WAYLAND_TOP=${STAGING_DIR}/usr \
            WAYLAND_SCANNER=${HOST_DIR}/usr/bin/wayland-scanner \
            APPLIBS_TARGET_LIB_DIR=${BCM_REFSW_BIN} \
            APPLIBS_TARGET_INC_DIR=${BCM_REFSW_BIN}/include; \
    \
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(WAYLAND_EGL_DIR) -f wayland_egl.mk \
            WAYLAND_SCANNER=${HOST_DIR}/usr/bin/wayland-scanner \
             WAYLAND_TOP=${STAGING_DIR}/usr \
            APPLIBS_TARGET_LIB_DIR=${BCM_REFSW_BIN} \
            APPLIBS_TARGET_INC_DIR=${BCM_REFSW_BIN}/include; \
fi
if [ $(shell expr $(BCM_REFSW_VERSION) \>= 17.1)$(shell expr $(BCM_REFSW_VERSION) \<= 17.3) = 11 ]; then \
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(WAYLAND_EGL_DIR) -f platform_wayland_server.mk \
            WAYLAND_SCANNER=${HOST_DIR}/usr/bin/wayland-scanner \
            APPLIBS_TARGET_LIB_DIR=${BCM_REFSW_BIN} \
            APPLIBS_TARGET_INC_DIR=${BCM_REFSW_BIN}/include ; \
fi

if [ $(shell expr $(BCM_REFSW_VERSION) \>= 17.1)$(shell expr $(BCM_REFSW_VERSION) \<= 17.3) = 11 ]; then \
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(WAYLAND_EGL_DIR) -f platform_wayland_client.mk \
            WAYLAND_SCANNER=${HOST_DIR}/usr/bin/wayland-scanner \
            APPLIBS_TARGET_LIB_DIR=${BCM_REFSW_BIN} \
            APPLIBS_TARGET_INC_DIR=${BCM_REFSW_BIN}/include ; \
fi

if [ $(shell expr $(BCM_REFSW_VERSION) \>= 17.4)$(shell expr $(BCM_REFSW_VERSION) \< 19.1) = 11 ]; then \
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(WAYLAND_EGL_DIR) -f platform_wayland.mk \
            WAYLAND_SCANNER=${HOST_DIR}/usr/bin/wayland-scanner \
             WAYLAND_TOP=${STAGING_DIR}/usr \
            APPLIBS_TARGET_LIB_DIR=${BCM_REFSW_BIN} \
            APPLIBS_TARGET_INC_DIR=${BCM_REFSW_BIN}/include ; \
fi

endef

ifeq ($(BCM_REFSW_PLATFORM_VC),vc5)
    define BCM_REFSW_INSTALL_STAGING_WAYLAND_EGL_GPU
            $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/interface/khronos/include/
            $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/interface/khronos/include/bcg_abstract

            ln -sf ../../../EGL $(STAGING_DIR)/usr/include/interface/khronos/include/
            ln -sf ../../../GLES $(STAGING_DIR)/usr/include/interface/khronos/include/
            ln -sf ../../../GLES2 $(STAGING_DIR)/usr/include/interface/khronos/include/
            ln -sf ../helpers $(STAGING_DIR)/usr/include/interface/khronos/include/

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

            $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/nexus/*.h $(STAGING_DIR)/usr/include/interface/khronos/include
            $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/khrn/egl/platform/bcg_abstract/*.h $(STAGING_DIR)/usr/include/interface/khronos/include/bcg_abstract
            $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/*.h $(STAGING_DIR)/usr/include/interface/khronos/include

            if [ $(shell expr $(BCM_REFSW_VERSION) \>= 19.1) = 1 ]; then \
                $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/stb/*.h $(STAGING_DIR)/usr/include/interface/khronos/include/bcg_abstract; \
                $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/stb/gmem_plat.inl $(STAGING_DIR)/usr/include/interface/khronos/include; \
            else \
                $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/bcg_abstract/*.h $(STAGING_DIR)/usr/include/interface/khronos/include/bcg_abstract; \
                $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/bcg_abstract/gmem_plat.inl $(STAGING_DIR)/usr/include/interface/khronos/include; \
            fi
            $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/platform/gmem.inl $(STAGING_DIR)/usr/include/interface/khronos/include

            #ursr16.2 extra copy
            $(INSTALL) -m 0755 -d $(STAGING_DIR)/usr/include/GLES3
			$(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/khrn/include/EGL/*.h   $(STAGING_DIR)/usr/include/EGL
			$(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/khrn/include/GLES/*.h  $(STAGING_DIR)/usr/include/GLES
			$(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/khrn/include/GLES2/*.h $(STAGING_DIR)/usr/include/GLES2
			$(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/khrn/include/GLES3/*.h $(STAGING_DIR)/usr/include/GLES3
			$(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/khrn/include/KHR/*.h   $(STAGING_DIR)/usr/include/KHR

            $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/refsw/bseav
            $(INSTALL) -m 0755 $(@D)/BSEAV/lib/media/*.h   $(STAGING_DIR)/usr/include/refsw/bseav

            #Install the c file for wayland-egl building usage.
            $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/nexus/display_nexus.c $(STAGING_DIR)/usr/share/wayland-egl
            $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/nexus/*.c             $(STAGING_DIR)/usr/share/wayland-egl/nexus
            $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/nexus/*.h             $(STAGING_DIR)/usr/share/wayland-egl/nexus
            $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/common/*.c            $(STAGING_DIR)/usr/share/wayland-egl/common
            $(INSTALL) -m 0644 $(@D)/BSEAV/lib/gpu/vc5/platform/common/*.h            $(STAGING_DIR)/usr/share/wayland-egl/common
            $(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/platform/common/*.cpp          $(STAGING_DIR)/usr/share/wayland-egl/common

            if [ -e $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_common.h ]; then \
                $(INSTALL) -m 0755 $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_common.h        $(STAGING_DIR)/usr/include;\
            fi

            if [ -e $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_v3d_hub_ctl.h ]; then \
                $(INSTALL) -m 0755 $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_v3d_hub_ctl.h        $(STAGING_DIR)/usr/include; \
            fi
            if [ -e $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_m2mc.h ]; then \
                $(INSTALL) -m 0755 $(@D)/magnum/basemodules/chp/include/${BCM_REFSW_BCHP_CHIP}/rdb/${BCM_REFSW_BCHP_VER_LOWER}/bchp_m2mc.h         $(STAGING_DIR)/usr/include; \
            fi
            if [ $(shell expr $(BCM_REFSW_VERSION) \>= 19.1) = 1 ]; then \
                $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/libs/core/gfx_buffer; \
                $(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/core/gfx_buffer/*.h $(STAGING_DIR)/usr/include/libs/core/gfx_buffer; \
                $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/libs/core/lfmt; \
                $(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/vc5/driver/libs/core/lfmt/*.h $(STAGING_DIR)/usr/include/libs/core/lfmt; \
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

define BCM_REFSW_INSTALL_WAYLAND_EGL_DEV
	$(call BCM_REFSW_INSTALL_WAYLAND_EGL,  $(STAGING_DIR))

    $(INSTALL) -m 644 package/bcm-refsw/${BCM_REFSW_PLATFORM_VC}/wayland-egl.pc $(STAGING_DIR)/usr/lib/pkgconfig/
    if [ $(shell expr $(BCM_REFSW_VERSION) \< 19.1) = 1 ]; then \
        $(INSTALL) -m 644 $(WAYLAND_EGL_DIR)/autogen/*.h $(STAGING_DIR)/usr/include/refsw/; \
    fi

    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share
    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share/wayland-egl
    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share/wayland-egl/common
    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/share/wayland-egl/nexus

    $(call BCM_REFSW_INSTALL_STAGING_WAYLAND_EGL_GPU)

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

define BCM_REFSW_INSTALL_WAYLAND_EGL
    if [ $(shell expr $(BCM_REFSW_VERSION) \< 19.1) = 1 ]; then \
        $(INSTALL) -m 644 -D $(WAYLAND_EGL_DIR)/lib_${BCM_REFSW_PLATFORM}_release/*.so $(1)/usr/lib; \
    fi
    if [ $(shell expr $(BCM_REFSW_VERSION) \>= 17.1)$(shell expr $(BCM_REFSW_VERSION) \<= 17.3) = 11 ]; then \
       $(INSTALL) -m 644 -D $(WAYLAND_EGL_DIR)/lib_${BCM_REFSW_PLATFORM}_release/libbcm_wayland_egl.so $(1)/usr/lib/libwayland-egl.so ;\
    fi
    if [ $(shell expr $(BCM_REFSW_VERSION) \>= 18.2) = 1 ]; then \
	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/libs/util/gfx_util/; \
        $(INSTALL) -m 0755 $(@D)/BSEAV/lib/gpu/${BCM_REFSW_PLATFORM_VC}/driver/libs/util/gfx_util/*.h $(STAGING_DIR)/usr/include/libs/util/gfx_util/; \
    fi
    if [ $(shell expr $(BCM_REFSW_VERSION) \>= 19.1) = 1 ]; then \
        $(INSTALL) -m 0755 $(@D)/BSEAV/linux/driver/brcmv3d/include/uapi/drm/brcmv3d_drm.h $(STAGING_DIR)/usr/include/; \
    else \
        if [ $(shell expr $(BCM_REFSW_VERSION) \>= 18.2) = 1 ]; then \
            $(INSTALL) -m 0755 $(@D)/magnum/portinginterface/${BCM_REFSW_PLATFORM_VC}/include/brcmv3d_drm.h $(STAGING_DIR)/usr/include/; \
        fi \
    fi
endef
