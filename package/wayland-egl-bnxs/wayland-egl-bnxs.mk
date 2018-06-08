################################################################################
#
# wayland-egl-bnxs
#
################################################################################

WAYLAND_EGL_BNXS_VERSION = ab76649310f6688670b5c88cfac184735afc4d21
WAYLAND_EGL_BNXS_SITE_METHOD = git
WAYLAND_EGL_BNXS_SITE = git@github.com:Metrological/wayland-egl-bnxs.git
WAYLAND_EGL_BNXS_INSTALL_STAGING = YES
WAYLAND_EGL_BNXS_AUTORECONF = YES
WAYLAND_EGL_BNXS_AUTORECONF_OPTS = "-Icfg"
WAYLAND_EGL_BNXS_DEPENDENCIES = host-pkgconf host-autoconf wayland bcm-refsw

WAYLAND_EGL_BNXS_CONF_OPTS = \
    --prefix=/usr/ \
    --disable-silent-rules \
    --disable-dependency-tracking \
    --enable-refsw_latest

WAYLAND_EGL_BNXS_INCLUDES += \
	-I$(STAGING_DIR)/usr/include/interface/khronos/include/bcg_abstract/ \
	-I$(STAGING_DIR)/usr/include/interface/khronos/include/ \
	-I${STAGING_DIR}/usr/include/refsw/ \
	-I$(STAGING_DIR)/usr/include/EGL/ \
	-I$(STAGING_DIR)/usr/include/

WAYLAND_EGL_BNXS_CFLAGS += \
	${WAYLAND_EGL_BNXS_INCLUDES} \
	-std=gnu99

WAYLAND_EGL_BNXS_CXXFLAGS += \
	${WAYLAND_EGL_BNXS_INCLUDES} \
	-std=c++11

ifeq ($(BR2_mipsel),y)
	WAYLAND_EGL_BNXS_CONF_OPTS += --enable-xg1v3_v3d
endif

ifeq ($(BR2_arm),y)
	WAYLAND_EGL_BNXS_CONF_OPTS += --enable-vc5
	WAYLAND_EGL_BNXS_CFLAGS += -DVCX=5
	WAYLAND_EGL_BNXS_CXXFLAGS += -DVCX=5

endif

WAYLAND_EGL_BNXS_MAKE_ENV = \
    REFSW_VERSION="$(STAGING_DIR)/usr/share/wayland-egl" \
    PKG_CONFIG_SYSROOT_DIR="$(STAGING_DIR)"

WAYLAND_EGL_BNXS_MAKE_OPTS = \
	CC="$(TARGET_CC)" \
	ARCH=$(KERNEL_ARCH) \
	PREFIX="$(TARGET_DIR)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	CONFIG_PREFIX="$(TARGET_DIR)" \
    CFLAGS="$(TARGET_CFLAGS) $(WAYLAND_EGL_BNXS_CFLAGS)" \
	CXXFLAGS="$(TARGET_CXXFLAGS) $(WAYLAND_EGL_BNXS_CXXFLAGS)"

define WAYLAND_EGL_BNXS_RUN_AUTOCONF
	mkdir -p $(@D)/cfg
endef
WAYLAND_EGL_BNXS_PRE_CONFIGURE_HOOKS += WAYLAND_EGL_BNXS_RUN_AUTOCONF

define WAYLAND_EGL_BNXS_REMOVE_LA
   rm $(STAGING_DIR)/usr/lib/libwayland-egl.la
endef

define WAYLAND_EGL_BNXS_GENERATE_PROTOCOL
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/protocol
endef

WAYLAND_EGL_BNXS_PRE_BUILD_HOOKS += WAYLAND_EGL_BNXS_GENERATE_PROTOCOL

WAYLAND_EGL_BNXS_POST_INSTALL_STAGING_HOOKS += WAYLAND_EGL_BNXS_REMOVE_LA

$(eval $(autotools-package))
