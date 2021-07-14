define BCM_REFSW_BUILD_NEXUS
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/nexus/build all \
			$(BCM_REFSW_BUILD_ADDITIONS)
endef

define BCM_REFSW_INSTALL_NEXUS
	$(INSTALL) -m 750 -D $(BCM_REFSW_BIN)/nexus $(1)/sbin/nexus
	$(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/nexus.ko $(1)/lib/modules/nexus.ko
	$(INSTALL) -D -m 755 package/bcm-refsw/S11nexus $(1)/etc/init.d/S11nexus
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnexus.so $(1)/usr/lib/libnexus.so
	if [ -f $(BCM_REFSW_BIN)/wakeup_drv.ko ]; then \
   	     $(INSTALL) -D -m 755 package/bcm-refsw/S11wakeup $(1)/etc/init.d/S11wakeup ; \
  	      $(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/wakeup_drv.ko $(1)/lib/modules/wakeup_drv.ko ; \
	fi
	# VC5 Graphics Execution Manger (GEM) interface
	if [ -f $(BCM_REFSW_BIN)/brcmv3d.ko ]; then \
		$(INSTALL) -D -m 755 package/bcm-refsw/S11brcmv3d $(1)/etc/init.d/S11brcmv3d ; \
		$(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/brcmv3d.ko $(1)/lib/modules/brcmv3d.ko ; \
	fi
endef

define BCM_REFSW_INSTALL_NEXUS_DEV
	$(call BCM_REFSW_INSTALL_NEXUS,$(STAGING_DIR))
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/refsw
	$(INSTALL) -m 644 $(BCM_REFSW_BIN)/include/*.h $(STAGING_DIR)/usr/include/refsw/
	$(INSTALL) -m 644 $(BCM_REFSW_OUTPUT)/nexus/bin/include/*.h $(STAGING_DIR)/usr/include/refsw/
	$(INSTALL) -m 644 $(BCM_REFSW_BIN)/include/platform_app.inc $(STAGING_DIR)/usr/include/
endef

BCM_NEXUS_CRYPTOGRAPHY_DIR = /BSEAV/lib/security
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CRYPTOGRAPHY),y)
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CRYPTOGRAPHY_IMPLEMENTATION_NEXUS),y)
define BCM_REFSW_INSTALL_CRYPTOGRAPHY_DEV
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_drm/include/drm_types.h $(1)/usr/include/refsw/
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_drm/include/drm_common.h $(1)/usr/include/refsw/
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_drm/include/drm_common_swcrypto_types.h $(1)/usr/include/refsw/
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_drm/include/tl/drm_types_tl.h $(1)/usr/include/refsw/
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_drm/include/tl/drm_common_tl.h $(1)/usr/include/refsw/	
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_drm/include/drm_metadata.h $(1)/usr/include/refsw/
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_drm/include/tl/drm_metadata_tl.h $(1)/usr/include/refsw/	
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/sage/platforms/include/drm_common_module_ids.h $(1)/usr/include/refsw/
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_crypto/include/common_crypto.h $(1)/usr/include/refsw/
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_crypto/include/common_crypto_secv1.h $(1)/usr/include/refsw/
	$(INSTALL) -D $(@D)/$(BCM_NEXUS_CRYPTOGRAPHY_DIR)/common_crypto/include/common_crypto_secv2.h $(1)/usr/include/refsw/
endef
endif
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_PMLIB),y)
define BCM_REFSW_BUILD_PMLIB
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
    CFLAGS="${CFLAGS} -fPIC" $(MAKE) -C $(@D)/BSEAV/lib/pmlib \
            LIBDIR=${BCM_REFSW_BIN}
endef

define BCM_REFSW_INSTALL_PMLIB_DEV
	$(INSTALL) -m 644 -D $(BCM_REFSW_OUTPUT)/BSEAV/lib/$(BR2_ARCH)-linux/pmlib/libpmlib.a $(STAGING_DIR)/usr/lib/libpmlib.a
	$(INSTALL) -m 644 $(BCM_REFSW_DIR)/BSEAV/lib/pmlib/$(BCM_PMLIB_VERSION)/pmlib.h $(STAGING_DIR)/usr/include/refsw
endef
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_EGLCUBE),y)
ifeq ($(shell expr $(BCM_REFSW_VERSION) \>= 17.1),1)
BCM_CUBE_DIR = /BSEAV/lib/gpu/applications/nexus/cube
else
BCM_CUBE_DIR = /rockford/applications/khronos/v3d/nexus/cube
endif

define BCM_REFSW_BUILD_EGLCUBE
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
               $(MAKE) -C $(@D)/$(BCM_CUBE_DIR) \
			LIBDIR=${BCM_REFSW_BIN}
endef
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE),y)
BCM_REFSW_INSTALL_SAGE_BINS_PATH = $(strip $(subst ",,$(BR2_PACKAGE_BCM_REFSW_SAGE_PATH)))

define BCM_REFSW_INSTALL_SAGE_BINS
    if [ -f $(BCM_REFSW_OUTPUT)/nexus/bin/sage_bl.bin ]; then \
    	$(INSTALL) -m 644 $(BCM_REFSW_OUTPUT)/nexus/bin/*.bin $(1)$(BCM_REFSW_INSTALL_SAGE_BINS_PATH) ; \
    fi
endef

BCM_NEXUS_SAGE_SRAI_DIR = /BSEAV/lib/security/sage/srai
BCM_MAGNUM_SAGE_SRAI_DIR = /magnum/syslib/sagelib
define BCM_REFSW_BUILD_SAGE_SRAI
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/$(BCM_NEXUS_SAGE_SRAI_DIR) \
            LIBDIR=${BCM_REFSW_BIN}
endef

define BCM_REFSW_INSTALL_SAGE_SRAI
    $(INSTALL) -D $(BCM_REFSW_BIN)/libsrai.so $(1)/usr/lib/libsrai.so
endef

define BCM_REFSW_INSTALL_SAGE_SRAI_DEV
    $(call BCM_REFSW_INSTALL_SAGE_SRAI,$(1))
    $(INSTALL) -m 644 $(@D)/$(BCM_NEXUS_SAGE_SRAI_DIR)/include/*.h $(STAGING_DIR)/usr/include/refsw/
    $(INSTALL) -m 644 $(@D)/$(BCM_MAGNUM_SAGE_SRAI_DIR)/include/*.h $(STAGING_DIR)/usr/include/refsw/
endef

ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE_BSECBUF),y)

BCM_NEXUS_SECBUF_DIR = /BSEAV/lib/security/secbuf
define BCM_REFSW_BUILD_SECBUF
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/$(BCM_NEXUS_SECBUF_DIR) \
            LIBDIR=${BCM_REFSW_BIN}
endef

define BCM_REFSW_INSTALL_SECBUF
    $(INSTALL) -D $(BCM_REFSW_OUTPUT)/$(BCM_NEXUS_SECBUF_DIR)/libb_secbuf.so $(1)/usr/lib/libb_secbuf.so
endef

define BCM_REFSW_INSTALL_SECBUF_DEV
    $(call BCM_REFSW_INSTALL_SECBUF,$(1))
    $(INSTALL) -m 644 $(@D)/$(BCM_NEXUS_SECBUF_DIR)/include/*.h $(STAGING_DIR)/usr/include/refsw/
endef

endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE_MANUFACTURING),y)
BCM_NEXUS_SAGE_MANUFACTURING_DIR = /BSEAV/lib/security/sage/manufacturing
define BCM_REFSW_BUILD_SAGE_MANUFACTURING
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/$(BCM_NEXUS_SAGE_MANUFACTURING_DIR)/src all \
            LIBDIR=${BCM_REFSW_BIN}
endef
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE_EXAMPLES),y)

BCM_NEXUS_SAGE_UTILITY_DIR = /BSEAV/lib/security/sage/utility
define BCM_REFSW_BUILD_SAGE_UTILITY
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/$(BCM_NEXUS_SAGE_UTILITY_DIR) all \
            LIBDIR=${BCM_REFSW_BIN}
endef

BCM_NEXUS_SAGE_EXAMPLE_DIR = /BSEAV/lib/security/sage/utility/examples/heartbeat
define BCM_REFSW_BUILD_SAGE_EXAMPLE
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/$(BCM_NEXUS_SAGE_EXAMPLE_DIR) \
            LIBDIR=${BCM_REFSW_BIN}
endef
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE_PLAYREADY_30),y)

BCM_NEXUS_PLAYREADY30_DIR = /BSEAV/thirdparty/playready/3.0

ifeq ($(shell expr $(BCM_REFSW_VERSION) \>= 19.2),1)
    BCM_NEXUS_PLAYREADY30_LIBDIR = $(BCM_NEXUS_PLAYREADY30_DIR)/bin/$(ARCH)-linux/secv2/lib
else ifeq ($(shell expr $(BCM_REFSW_VERSION) \>= 18.1),1)
ifeq ($(BCM_REFSW_PLATFORM_SECURITY_ZEUS_VERSION),5)
    BCM_NEXUS_PLAYREADY30_LIBDIR = $(BCM_NEXUS_PLAYREADY30_DIR)/bin/$(ARCH)-linux/Zeus5x/lib
else
    BCM_NEXUS_PLAYREADY30_LIBDIR = $(BCM_NEXUS_PLAYREADY30_DIR)/bin/$(ARCH)-linux/Zeus4x/lib
endif
else
    BCM_NEXUS_PLAYREADY30_LIBDIR = $(BCM_NEXUS_PLAYREADY30_DIR)/bin/$(ARCH)-linux/lib
endif

define BCM_REFSW_INSTALL_PLAYREADY30_DEV
    $(INSTALL) -D $(@D)/$(BCM_NEXUS_PLAYREADY30_DIR)/inc/* $(1)/usr/include/refsw/
    $(INSTALL) -D $(@D)/$(BCM_NEXUS_PLAYREADY30_DIR)/../http/include/* $(1)/usr/include/refsw/
    $(INSTALL) -D $(@D)/BSEAV/lib/drmrootfs/drm_data.h $(1)/usr/include/refsw/
    $(INSTALL) -D $(@D)/$(BCM_NEXUS_PLAYREADY30_LIBDIR)/* $(1)/usr/lib/
endef

define BCM_REFSW_INSTALL_PLAYREADY30
    $(INSTALL) -D $(@D)/$(BCM_NEXUS_PLAYREADY30_LIBDIR)/*.so $(1)/usr/lib/
endef

BCM_NEXUS_DRMROOTFS_DIR = /BSEAV/lib/drmrootfs
define BCM_REFSW_BUILD_DRMROOTFS
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/$(BCM_NEXUS_DRMROOTFS_DIR) all \
            LIBDIR=${BCM_REFSW_BIN}
endef

define BCM_REFSW_INSTALL_DRMROOTFS_DEV
    $(INSTALL) -D $(@D)/$(BCM_NEXUS_DRMROOTFS_DIR)/drm_data.h $(1)/usr/include/refsw/
    $(INSTALL) -D $(BCM_REFSW_OUTPUT)/$(BCM_NEXUS_DRMROOTFS_DIR)/libdrmrootfs.so $(1)/usr/lib/libdrmrootfs.so
endef

define BCM_REFSW_INSTALL_DRMROOTFS
    $(INSTALL) -D $(BCM_REFSW_OUTPUT)/$(BCM_NEXUS_DRMROOTFS_DIR)/libdrmrootfs.so $(1)/usr/lib/libdrmrootfs.so
endef

BCM_NEXUS_PRDYHTTP_DIR = /BSEAV/thirdparty/playready/http
define BCM_REFSW_BUILD_PRDYHTTP
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/$(BCM_NEXUS_PRDYHTTP_DIR) all \
            LIBDIR=${BCM_REFSW_BIN}
endef

define BCM_REFSW_INSTALL_PRDYHTTP_DEV
    $(INSTALL) -D $(@D)/$(BCM_NEXUS_PRDYHTTP_DIR)/include/prdy_http.h $(1)/usr/include/refsw/
    $(INSTALL) -D $(BCM_REFSW_OUTPUT)/$(BCM_NEXUS_PRDYHTTP_DIR)/libprdyhttp.so $(1)/usr/lib/libprdyhttp.so
endef

define BCM_REFSW_INSTALL_PRDYHTTP
    $(INSTALL) -D $(BCM_REFSW_OUTPUT)/$(BCM_NEXUS_PRDYHTTP_DIR)/libprdyhttp.so $(1)/usr/lib/libprdyhttp.so
endef

ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE_PLAYREADY_30_EXAMPLE),y)
BCM_NEXUS_SAGE_PRDY30_SVP_DIR = /BSEAV/thirdparty/playready/3.0/examples
define BCM_REFSW_BUILD_SAGE_PRDY30_SVP
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/$(BCM_NEXUS_SAGE_PRDY30_SVP_DIR) target=prdy30_svp all \
            LIBDIR=${BCM_REFSW_BIN}
endef
endif
endif

endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_SAGE_WIDEVINE_VERSION_15),y)

BCM_NEXUS_WIDEVINE_DIR = /BSEAV/lib/security/third_party/widevine/CENC_v15

define BCM_REFSW_BUILD_SAGE_WIDEVINE
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/$(BCM_NEXUS_WIDEVINE_DIR) build_wv_bundle \
            LIBDIR=${BCM_REFSW_BIN}
endef


define BCM_REFSW_INSTALL_WIDEVINE_DEV
endef

define BCM_REFSW_INSTALL_WIDEVINE
endef

endif

define BCM_REFSW_BUILD_NEXUS_LIBB_OS
    $(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/nexus/lib/os all \
			$(BCM_REFSW_BUILD_ADDITIONS)
endef

define BCM_REFSW_INSTALL_NEXUS_LIBB_OS
	$(INSTALL) -D $(BCM_REFSW_BIN)/libb_os.so $(1)/usr/lib/libb_os.so
endef

define BCM_REFSW_INSTALL_NEXUS_LIBB_OS_DEV
	$(INSTALL) -m 755 -d $(1)/usr/include/refsw/os
	$(call BCM_REFSW_INSTALL_NEXUS_LIBB_OS,$(STAGING_DIR))
	cp -a $(@D)/nexus/lib/os/include/* $(1)/usr/include/refsw/os
endef

ifeq ($(BR2_PACKAGE_BCM_REFSW_KERNELSPACE_HEADERS),y)
define BCM_REFSW_BUILD_NEXUS_KERNEL_HEADERS
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/refsw/linuxkernel
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	NEXUS_BIN_DIR=$(STAGING_DIR)/usr/include/refsw/linuxkernel \
	B_REFSW_ARCH=$(ARCH)-linux \
	PLATFORM=${BCM_REFSW_PLATFORM} \
	NEXUS_PLATFORM=${BCM_REFSW_PLATFORM} \
	BCHP_CHIP=${BCM_REFSW_BCHP_CHIP} \
	BCHP_VER=${BCM_REFSW_PLATFORM_REV} \
	BCHP_VER_LC=${BCM_REFSW_BCHP_VER_LOWER} \
	BCHP_KERNEL_VER=${BCM_REFSW_BCHP_CHIP}${BCM_REFSW_BCHP_VER_LOWER} \
	BCHP_DEFCONFIG=bcm${BCM_REFSW_BCHP_CHIP}${BCM_REFSW_BCHP_VER_LOWER} \
	BCM_CONFIG=${BCM_REFSW_BCHP_CHIP}${BCM_REFSW_BCHP_VER_LOWER} \
	B_REFSW_CROSS_COMPILE=${TARGET_CROSS} \
	OS=linuxkernel \
	MODE=linuxkernel \
	B_REFSW_OS=linuxkernel \
		$(MAKE) -C $(@D)/nexus/build nexus_headers \
			$(BCM_REFSW_BUILD_ADDITIONS)

	$(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/../core/linuxkernel.$(ARCH)-linux.driver/Module.symvers $(STAGING_DIR)/usr/include/refsw/linuxkernel
	$(INSTALL) -m 755 -D $(BCM_REFSW_BIN)/../core/linuxkernel.$(ARCH)-linux.driver/libnexus_driver.a  $(STAGING_DIR)/usr/include/refsw/linuxkernel
endef
endif

define BCM_REFSW_GENERATE_NEXUS_PC
  package/bcm-refsw/generate_nexus_pc.sh ${BCM_REFSW_BIN} package/bcm-refsw/nexus.pc.template  ${BCM_REFSW_OUTPUT}
endef

define BCM_REFSW_INSTALL_NEXUS_PC
  $(INSTALL) -D $(BCM_REFSW_OUTPUT)/nexus.pc $(1)/usr/lib/pkgconfig/
  $(INSTALL) -D $(BCM_REFSW_OUTPUT)/nexus-client.pc $(1)/usr/lib/pkgconfig/
endef
