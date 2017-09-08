################################################################################
#
# wayland-egl-bnxs
#
################################################################################

WAYLAND_EGL_BNXS_VERSION = 34d42332cb4b43bfa656060e1a4314c856ff768a
WAYLAND_EGL_BNXS_SITE_METHOD = git
WAYLAND_EGL_BNXS_SITE = git@github.com:Metrological/wayland-egl-bnxs.git
WAYLAND_EGL_BNXS_INSTALL_STAGING = YES
WAYLAND_EGL_BNXS_AUTORECONF = YES
WAYLAND_EGL_BNXS_AUTORECONF_OPTS = "-Icfg"
WAYLAND_EGL_BNXS_DEPENDENCIES = host-pkgconf host-autoconf wayland bcm-refsw

WAYLAND_EGL_BNXS_CFLAGS = \
	-I$(STAGING_DIR)/usr/include/interface/khronos/include/bcg_abstract/ \
	-I$(STAGING_DIR)/usr/include/interface/khronos/include/ \
	-I${STAGING_DIR}/usr/include/refsw/
	
WAYLAND_EGL_BNXS_CONF_OPTS = \
	--prefix=/usr/ \
    --disable-silent-rules \
    --disable-dependency-tracking \
    --enable-refsw_latest \
    --enable-vc5	

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
	CXXFLAGS="$(TARGET_CXXFLAGS) $(WAYLAND_EGL_BNXS_CFLAGS)" 
     

define WAYLAND_EGL_BNXS_RUN_AUTOCONF
	mkdir -p $(@D)/cfg
endef
WAYLAND_EGL_BNXS_PRE_CONFIGURE_HOOKS += WAYLAND_EGL_BNXS_RUN_AUTOCONF

define WAYLAND_EGL_BNXS_GENERATE_PROTOCOL
	SCANNER_TOOL=${HOST_DIR}/usr/bin/wayland-scanner $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/protocol
endef
WAYLAND_EGL_BNXS_PRE_BUILD_HOOKS += WAYLAND_EGL_BNXS_GENERATE_PROTOCOL

$(eval $(autotools-package))
