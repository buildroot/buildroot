BCM_WESTON_VERSION = a9fd90732aacc503019988042d9d1485c6a0b670
BCM_WESTON_SITE = git@github.com:Metrological/bcm-refsw.git
BCM_WESTON_SITE_METHOD = git
BCM_WESTON_DEPENDENCIES = libffi expat libxkbcommon pixman libpng jpeg mtdev udev cairo libinput linux-pam bcm-refsw libxml2 imagemagick
BCM_WESTON_LICENSE = PROPRIETARY
BCM_WESTON_INSTALL_STAGING = YES
BCM_WESTON_INSTALL_TARGET = YES

ifeq ($(BR2_arm),y)
BCM_WESTON_PLATFORM = 97439
BCM_WESTON_PLATFORM_REV = B0
BCM_WESTON_PLATFORM_VC = vc5
else ifeq ($(BR2_mipsel),y)
BCM_WESTON_PLATFORM = 97429
BCM_WESTON_PLATFORM_REV = B0
BCM_WESTON_PLATFORM_VC = v3d
endif

BCM_WESTON_CONF_OPTS += \
	CROSS_COMPILE="${TARGET_CROSS}" \
	LINUX=${LINUX_DIR} \
	HOST_DIR="${HOST_DIR}"

BCM_WESTON_MAKE_ENV += \
	B_REFSW_ARCH=$(ARCH)-linux \
	B_REFSW_VERBOSE=y \
	B_REFSW_DEBUG_LEVEL=wrn \
	BCHP_VER=$(BCM_WESTON_PLATFORM_REV) \
	NEXUS_TOP="$(BCM_WESTON_DIR)/nexus" \
	NEXUS_PLATFORM=$(BCM_WESTON_PLATFORM) \
	NEXUS_USE_7439_SFF=y \
	NEXUS_MODE=proxy \
	NEXUS_HEADERS=y \
	NEXUS_EXTRA_CFLAGS="$(TARGET_CFLAGS) -fPIC" \
	NEXUS_EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
	VCX=$(BCM_WESTON_PLATFORM_VC) \
	V3D_SUPPORT=y \
	V3D_EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
	V3D_EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
	CLIENT=y \
	USE_NXCLIENT=0 \
	surface_compositor=y

ifeq ($(filter ${B_REFSW_ARCH}, mips-linux mips-uclibc mips-linux-uclibc), ${B_REFSW_ARCH})
BCM_WESTON_MAKE_ENV += NEXUS_ENDIAN=BSTD_ENDIAN_BIG
else
BCM_WESTON_MAKE_ENV += NEXUS_ENDIAN=BSTD_ENDIAN_LITTLE
endif

ifeq ($(BCM_WESTON_PLATFORM_VC),vc5)
TARGET_CFLAGS += -DVCX=5
else
TARGET_CFLAGS += -DVCX=4
endif

define BCM_WESTON_BUILD_WAYLAND
	@echo "********************************************************************";
	@echo "building wayland";
	@echo "********************************************************************";
        # build wayland-scanner
	$(HOST_CONFIGURE_OPTS) \
	$(HOST_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/opensource/wayland wayland-scanner -f Makefile.buildroot;
        # install wayland-scanner to staging, despite bcm stuff will use it from the build dir
	$(INSTALL) -m 755 -D $(@D)/AppLibs/opensource/wayland/build/wayland-scanner $(HOST_DIR)/usr/bin/wayland-scanner
	$(INSTALL) -m 0644 -D $(@D)/AppLibs/opensource/wayland/scanner/src/wayland-scanner.pc  $(STAGING_DIR)/usr/lib/pkgconfig/wayland-scanner.pc
	$(SED) 's:^prefix=.*:prefix=/usr:' \
		-e 's:^wayland_scanner=.*:wayland_scanner=$(HOST_DIR)/usr/bin/wayland-scanner:' \
		$(STAGING_DIR)/usr/lib/pkgconfig/wayland-scanner.pc
        # build wayland
	$(TARGET_CONFIGURE_OPTS) \
	$(BCM_WESTON_CONF_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/opensource/wayland wayland -f Makefile.buildroot \
			TARGET_NAME=$(GNU_TARGET_NAME) HOST_NAME=$(GNU_HOST_NAME) \
			STAGING_DIR=$(STAGING_DIR) TARGET_DIR=$(TARGET_DIR);
        # we need to fix the .la files manually cause the won't be fixed until after the INSTALL_STAGING phase
        # but we need them fixed for the next packages
	$(SED) 's:^libdir=.*:libdir='\''$(STAGING_DIR)/usr/lib'\'':' $(STAGING_DIR)/usr/lib/libwayland-client.la;
	$(SED) 's:^libdir=.*:libdir='\''$(STAGING_DIR)/usr/lib'\'':' $(STAGING_DIR)/usr/lib/libwayland-server.la;
	$(SED) 's:^libdir=.*:libdir='\''$(STAGING_DIR)/usr/lib'\'':' $(STAGING_DIR)/usr/lib/libwayland-cursor.la;
	$(SED) 's:/usr/lib/libwayland-client.la:$(STAGING_DIR)/usr/lib/libwayland-client.la:' $(STAGING_DIR)/usr/lib/libwayland-cursor.la;
endef

define BCM_WESTON_BUILD_NSC_PROTOCOL
	@echo "********************************************************************";
	@echo "building nsc-protocol";
	@echo "********************************************************************";
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/broadcom/weston/protocol -f Makefile.buildroot;
endef

define BCM_WESTON_BUILD_NXPL_WAYLAND
	@echo "********************************************************************";
	@echo "building nxpl-wayland";
	@echo "********************************************************************";
	$(TARGET_CONFIGURE_OPTS) \
	$(BCM_WESTON_CONF_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/broadcom/weston/nxpl-wayland/ -f Makefile.buildroot;
	$(INSTALL) -D $(@D)/AppLibs/broadcom/weston/nxpl-wayland/libnxpl-weston.so $(STAGING_DIR)/usr/lib/
	$(INSTALL) -D $(@D)/AppLibs/broadcom/weston/nxpl-wayland/libnxpl-weston.so $(TARGET_DIR)/usr/lib/
	$(TARGET_CONFIGURE_OPTS) \
	$(BCM_WESTON_CONF_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/broadcom/weston/nxpl-wayland/ -f Makefile.buildroot clean;
	$(TARGET_CONFIGURE_OPTS) \
	$(BCM_WESTON_CONF_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/broadcom/weston/nxpl-wayland/ -f Makefile.buildroot NXPL_USE_NXCLIENT="y";
	$(INSTALL) -D $(@D)/AppLibs/broadcom/weston/nxpl-wayland/libnxpl-nxclient.so $(STAGING_DIR)/usr/lib/
	$(INSTALL) -D $(@D)/AppLibs/broadcom/weston/nxpl-wayland/libnxpl-nxclient.so $(TARGET_DIR)/usr/lib/
endef


define BCM_WESTON_BUILD_WAYLAND_EGL
	@echo "********************************************************************";
	@echo "building wayland-egl";
	@echo "********************************************************************";
	$(TARGET_CONFIGURE_OPTS) \
	$(BCM_WESTON_CONF_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/broadcom/weston/wayland-egl/ STAGING_DIR=$(STAGING_DIR) -f Makefile.buildroot;
	$(INSTALL) -D $(@D)/AppLibs/broadcom/weston/wayland-egl/libwayland-egl.so $(STAGING_DIR)/usr/lib/
	$(INSTALL) -m 644 -D $(@D)/AppLibs/broadcom/weston/wayland-egl/wayland-egl.pc $(STAGING_DIR)/usr/lib/pkgconfig/
	$(INSTALL) -m 644 -D $(@D)/AppLibs/broadcom/weston/wayland-egl/egl.pc $(STAGING_DIR)/usr/lib/pkgconfig/
	$(INSTALL) -D $(@D)/AppLibs/broadcom/weston/wayland-egl/libwayland-egl.so $(TARGET_DIR)/usr/lib/
endef

define BCM_WESTON_BUILD_WESTON
	@echo "********************************************************************";
	@echo "building weston";
	@echo "********************************************************************";
	$(TARGET_CONFIGURE_OPTS) \
	$(BCM_WESTON_CONF_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/opensource/weston/ -f Makefile.buildroot \
			TARGET_NAME=$(GNU_TARGET_NAME) HOST_NAME=$(GNU_HOST_NAME) \
			STAGING_DIR=$(STAGING_DIR) TARGET_DIR=$(TARGET_DIR);
	cp -R $(@D)/AppLibs/opensource/fonts $(TARGET_DIR)/usr/share/;
	cp -R $(@D)/AppLibs/broadcom/weston/data/* $(TARGET_DIR)/usr/share/weston;
endef

define BCM_WESTON_BUILD_NSC_BACKEND
	@echo "********************************************************************";
	@echo "building nsc-backend";
	@echo "********************************************************************";
	$(TARGET_CONFIGURE_OPTS) \
	$(BCM_WESTON_CONF_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/broadcom/weston/weston/nsc-backend -f Makefile.buildroot \
			STAGING_DIR=$(STAGING_DIR) TARGET_DIR=$(TARGET_DIR);
endef

define BCM_WESTON_BUILD_WAYLAND_NXCLIENT
	@echo "********************************************************************";
	@echo "building wayland-nxclient";
	@echo "********************************************************************";
	$(TARGET_CONFIGURE_OPTS) \
	$(BCM_WESTON_CONF_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/broadcom/weston/wayland-nxclient -f Makefile.buildroot;
			STAGING_DIR=$(STAGING_DIR) TARGET_DIR=$(TARGET_DIR);
endef

define BCM_WESTON_BUILD_SETTOP_SHELL
	@echo "********************************************************************";
	@echo "building settop-shell";
	@echo "********************************************************************";
	$(TARGET_CONFIGURE_OPTS) \
	$(BCM_WESTON_CONF_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_WESTON_MAKE_ENV) \
		$(MAKE) -C $(@D)/AppLibs/broadcom/weston/settop-shell -f Makefile.buildroot;
			STAGING_DIR=$(STAGING_DIR) TARGET_DIR=$(TARGET_DIR);
endef

define BCM_WESTON_BUILD_CMDS
	$(BCM_WESTON_BUILD_WAYLAND)
	$(BCM_WESTON_BUILD_NSC_PROTOCOL)
	$(BCM_WESTON_BUILD_NXPL_WAYLAND)
	$(BCM_WESTON_BUILD_WAYLAND_EGL)
	$(BCM_WESTON_BUILD_WESTON)
	$(BCM_WESTON_BUILD_NSC_BACKEND)
	$(BCM_WESTON_BUILD_WAYLAND_NXCLIENT)
	$(BCM_WESTON_BUILD_SETTOP_SHELL)
endef

define BCM_WESTON_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 package/bcm-weston/S70weston $(TARGET_DIR)/etc/init.d/S70weston
endef

$(eval $(generic-package))
