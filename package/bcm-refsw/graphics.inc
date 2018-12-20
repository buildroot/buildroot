define BCM_REFSW_BUILD_GRAPHICS
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

define BCM_REFSW_INSTALL_GRAPHICS
	$(INSTALL) -D $(BCM_REFSW_BIN)/libv3ddriver.so $1/usr/lib/libv3ddriver.so
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnxpl.so $1/usr/lib/libnxpl.so
	cd $1/usr/lib && ln -sf libv3ddriver.so libEGL.so && ln -sf libv3ddriver.so libGLESv2.so
endef

ifneq ($(BR2_PACKAGE_BCM_REFSW_V3D_DRM),y)
EGL_EXTRA_CFLAGS += -DV3D_DRM_DISABLE
endif

define BCM_REFSW_INSTALL_GRAPHICS_DEV
	$(call BCM_REFSW_INSTALL_GRAPHICS,$(STAGING_DIR))
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib/pkgconfig
	$(INSTALL) -m 644 package/bcm-refsw/${BCM_REFSW_PLATFORM_VC}/egl.pc $(STAGING_DIR)/usr/lib/pkgconfig/egl.pc
	$(INSTALL) -m 644 package/bcm-refsw/${BCM_REFSW_PLATFORM_VC}/glesv2.pc $(STAGING_DIR)/usr/lib/pkgconfig/
	sed -i 's/@CFLAGS@/${EGL_EXTRA_CFLAGS}/g' $(STAGING_DIR)/usr/lib/pkgconfig/egl.pc; \
	sed -i 's/@CFLAGS@/${EGL_EXTRA_CFLAGS}/g' $(STAGING_DIR)/usr/lib/pkgconfig/glesv2.pc; \
    $(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/GLES
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/GLES2
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/EGL
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/KHR
    $(INSTALL) -m 644 ${BCM_REFSW_VCX_KHRN}/GLES/*.h $(STAGING_DIR)/usr/include/GLES/
	$(INSTALL) -m 644 ${BCM_REFSW_VCX_KHRN}/GLES2/*.h $(STAGING_DIR)/usr/include/GLES2/
	$(INSTALL) -m 644 ${BCM_REFSW_VCX_KHRN}/EGL/*.h $(STAGING_DIR)/usr/include/EGL/
	$(INSTALL) -m 644 ${BCM_REFSW_VCX_KHRN}/KHR/*.h $(STAGING_DIR)/usr/include/KHR/
    $(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/refsw
	$(INSTALL) -m 644 ${BCM_REFSW_VCX}/platform/nexus/*.h $(STAGING_DIR)/usr/include/refsw/
endef
