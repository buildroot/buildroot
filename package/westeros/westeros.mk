################################################################################
#
# westeros
#
################################################################################

WESTEROS_VERSION = 6fed670094ef307a85876c675fc42a3291fd5175
WESTEROS_SITE_METHOD = git
WESTEROS_SITE = git://github.com/Metrological/westeros
WESTEROS_INSTALL_STAGING = YES
WESTEROS_AUTORECONF = YES
WESTEROS_AUTORECONF_OPTS = "-Icfg"

WESTEROS_DEPENDENCIES = host-pkgconf host-autoconf wayland \
	libxkbcommon westeros-simpleshell westeros-simplebuffer westeros-soc gstreamer1

WESTEROS_CONF_OPTS = \
	--prefix=/usr/ \
	--enable-app=yes \
	--enable-test=yes \
	--enable-rendergl=yes \
	--enable-sbprotocol=yes \
	--enable-xdgv5=yes

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	WESTEROS_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) -DWESTEROS_PLATFORM_RPI -DWESTEROS_INVERTED_Y -DBUILD_WAYLAND -I${STAGING_DIR}/usr/include/interface/vmcs_host/linux"
	WESTEROS_LDFLAGS += -lEGL -lGLESv2 -lbcm_host
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
	WESTEROS_CONF_ENV += \
		PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR) 
	WESTEROS_CONF_OPTS += \
		--enable-vc5=yes \
		CFLAGS="$(TARGET_CFLAGS) -I${STAGING_DIR}/usr/include/refsw/" \
		CXXFLAGS="$(TARGET_CXXFLAGS) -I${STAGING_DIR}/usr/include/refsw/"
	WESTEROS_MAKE_OPTS += \
		PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR) \
		$(BCM_REFSW_MAKE_ENV)	
	WESTEROS_DEPENDENCIES += wayland-egl-bnxs bcm-refsw
else ifeq ($(BR2_PACKAGE_LIBDRM),y)
	WESTEROS_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) -DWESTEROS_PLATFORM_DRM -I${STAGING_DIR}/usr/include/interface/vmcs_host/linux"
endif # BR2_PACKAGE_WESTEROS_SOC_RPI


define WESTEROS_RUN_AUTOCONF
	mkdir -p $(@D)/cfg
endef
WESTEROS_PRE_CONFIGURE_HOOKS += WESTEROS_RUN_AUTOCONF


define WESTEROS_BUILD_CMDS
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/protocol
	$(WESTEROS_MAKE_OPTS) \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(WESTEROS_LDFLAGS)
endef

define WESTEROS_INSTALL_STAGING_CMDS
	$(MAKE1) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

define WESTEROS_INSTALL_TARGET_CMDS
	$(MAKE1) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(autotools-package))
