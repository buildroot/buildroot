################################################################################
#
# sdl2
#
################################################################################

SDL2_VERSION = 2.0.3
SDL2_SOURCE = SDL2-$(SDL2_VERSION).tar.gz
SDL2_SITE = http://www.libsdl.org/release
SDL2_LICENSE = LGPLv2.1+
SDL2_LICENSE_FILES = COPYING
SDL2_INSTALL_STAGING = YES

# we're patching configure.in, but package cannot autoreconf with our version of
# autotools, so we have to do it manually instead of setting SDL2_AUTORECONF = YES
define SDL2_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef

SDL2_PRE_CONFIGURE_HOOKS += SDL2_RUN_AUTOGEN
HOST_SDL2_PRE_CONFIGURE_HOOKS += SDL2_RUN_AUTOGEN

SDL2_DEPENDENCIES += host-automake host-autoconf host-libtool
HOST_SDL2_DEPENDENCIES += host-automake host-autoconf host-libtool

ifeq ($(BR2_PACKAGE_SDL2_FBCON),y)
SDL2_CONF_OPTS += --enable-video-fbcon=yes
else
SDL2_CONF_OPTS += --enable-video-fbcon=no
endif

ifeq ($(BR2_PACKAGE_SDL2_DIRECTFB),y)
SDL2_DEPENDENCIES += directfb
SDL2_CONF_OPTS += --enable-video-directfb=yes
SDL2_CONF_ENV = ac_cv_path_DIRECTFBCONFIG=$(STAGING_DIR)/usr/bin/directfb-config
else
SDL2_CONF_OPTS = --enable-video-directfb=no
endif

ifeq ($(BR2_PACKAGE_SDL2_QTOPIA),y)
SDL2_CONF_OPTS += --enable-video-qtopia=yes
SDL2_DEPENDENCIES += qt
else
SDL2_CONF_OPTS += --enable-video-qtopia=no
endif

ifeq ($(BR2_PACKAGE_SDL2_X11),y)
SDL2_CONF_OPTS += --enable-video-x11=yes
SDL2_DEPENDENCIES += xlib_libX11 xlib_libXext \
	$(if $(BR2_PACKAGE_XLIB_LIBXRENDER), xlib_libXrender) \
	$(if $(BR2_PACKAGE_XLIB_LIBXRANDR), xlib_libXrandr)
else
SDL2_CONF_OPTS += --enable-video-x11=no
endif

ifneq ($(BR2_USE_MMU),y)
SDL2_CONF_OPTS += --enable-dga=no
endif

ifeq ($(BR2_PACKAGE_TSLIB),y)
SDL2_DEPENDENCIES += tslib
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
SDL2_DEPENDENCIES += alsa-lib
endif

ifeq ($(BR2_PACKAGE_MESA3D),y)
SDL2_DEPENDENCIES += mesa3d
endif

SDL2_CONF_OPTS += --enable-pulseaudio=no \
		--disable-arts \
		--disable-esd \
		--disable-nasm \
		--disable-video-ps3

HOST_SDL2_CONF_OPTS += --enable-pulseaudio=no \
		--enable-video-x11=no \
		--disable-arts \
		--disable-esd \
		--disable-nasm \
		--disable-video-ps3

SDL2_CONFIG_SCRIPTS = sdl2-config

# Remove the -Wl,-rpath option.
define SDL2_FIXUP_SDL2_CONFIG
	$(SED) 's%-Wl,-rpath,\$${libdir}%%' \
		$(STAGING_DIR)/usr/bin/sdl2-config
endef

SDL2_POST_INSTALL_STAGING_HOOKS += SDL2_FIXUP_SDL2_CONFIG

$(eval $(autotools-package))
$(eval $(host-autotools-package))
