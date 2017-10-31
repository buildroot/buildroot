################################################################################
#
# westeros-soc
#
################################################################################

WESTEROS_SOC_VERSION = 9633867603dcfb2a5c71af71e7e1abd12f0c2ca3
WESTEROS_SOC_SITE_METHOD = git
WESTEROS_SOC_SITE = git://github.com/Metrological/westeros
WESTEROS_SOC_INSTALL_STAGING = YES
WESTEROS_SOC_AUTORECONF = YES
WESTEROS_SOC_AUTORECONF_OPTS = "-Icfg"

WESTEROS_SOC_DEPENDENCIES = host-pkgconf host-autoconf wayland libegl

WESTEROS_SOC_CONF_OPTS += \
	--prefix=/usr/ \
    --disable-silent-rules \
    --disable-dependency-tracking \

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	WESTEROS_SOC_CONF_OPTS += CFLAGS="$(TARGET_CFLAGS) -I ${STAGING_DIR}/usr/include/interface/vmcs_host/linux/"
	WESTEROS_SOC_SUBDIR = rpi
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
	WESTEROS_SOC_MAKE_ENV += \
		$(BCM_REFSW_MAKE_ENV) \
        REFSW_VERSION="$(STAGING_DIR)/usr/share/wayland-egl" \
		PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR)
	WESTEROS_SOC_CONF_OPTS += \
        --enable-vc5 \
		CFLAGS="$(TARGET_CFLAGS) -I ${STAGING_DIR}/usr/include/refsw/" \
		CXXFLAGS="$(TARGET_CXXFLAGS) -I ${STAGING_DIR}/usr/include/refsw/"
	WESTEROS_SOC_SUBDIR = brcm
    WESTEROS_SOC_DEPENDENCIES += wayland-egl-bnxs bcm-refsw
else ifeq ($(BR2_PACKAGE_LIBDRM),y)
	WESTEROS_SOC_CONF_OPTS += CFLAGS="$(TARGET_CFLAGS) -I $(STAGING_DIR)/usr/include/libdrm"
	WESTEROS_SOC_SUBDIR = drm
	WESTEROS_SOC_DEPENDENCIES += libdrm
endif

define WESTEROS_SOC_RUN_AUTOCONF
	mkdir -p $(@D)/$(WESTEROS_SOC_SUBDIR)/cfg
endef
WESTEROS_SOC_PRE_CONFIGURE_HOOKS += WESTEROS_SOC_RUN_AUTOCONF

define WESTEROS_SOC_ENTER_BUILD_DIR
	cd $(@D)/$(WESTEROS_SOC_SUBDIR)
endef
WESTEROS_SOC_PRE_BUILD_HOOKS += WESTEROS_SOC_ENTER_BUILD_DIR

$(eval $(autotools-package))
