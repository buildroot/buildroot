################################################################################
#
# qt5webengine
#
################################################################################

QT5WEBENGINE_VERSION = $(QT5_VERSION)
QT5WEBENGINE_SITE = $(QT5_SITE)/qtwebengine/-/archive/v$(QT5WEBENGINE_VERSION)-lts
QT5WEBENGINE_SOURCE = qtwebengine-v$(QT5WEBENGINE_VERSION)-lts.tar.bz2
QT5WEBENGINE_DEPENDENCIES = qt5declarative qt5webchannel
QT5WEBENGINE_PATCH_DEPENDENCIES = qt5webengine-chromium
QT5WEBENGINE_INSTALL_STAGING = YES
QT5WEBENGINE_SYNC_QT_HEADERS = YES

QT5WEBENGINE_LICENSE = GPL-2.0 or LGPL-3.0 or GPL-3.0 or GPL-3.0 with exception
QT5WEBENGINE_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT \
	LICENSE.GPLv3 LICENSE.LGPL3

# command line argument separator
QT5WEBENGINE_CONF_OPTS = --

ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
QT5WEBENGINE_DEPENDENCIES += qt5svg
endif

ifeq ($(BR2_PACKAGE_QT5BASE_XCB),y)
QT5WEBENGINE_DEPENDENCIES += \
	xlib_libXcomposite \
	xlib_libXcursor \
	xlib_libXi \
	xlib_libxkbfile \
	xlib_libXrandr \
	xlib_libXScrnSaver \
	xlib_libXtst
QT5WEBENGINE_CONF_OPTS += \
	-feature-webengine-ozone \
	-feature-webengine-system-libdrm \
	-feature-webengine-system-x11 \
	-feature-webengine-system-xkbfile \
	-feature-webengine-system-xcomposite \
	-feature-webengine-system-xcursor \
	-feature-webengine-system-xi \
	-feature-webengine-system-xproto-gl \
	-feature-webengine-system-xtst
else
QT5WEBENGINE_CONF_OPTS += \
	-no-feature-webengine-ozone \
	-no-feature-webengine-system-libdrm \
	-no-feature-webengine-system-x11 \
	-no-feature-webengine-system-xkbfile \
	-no-feature-webengine-system-xcomposite \
	-no-feature-webengine-system-xcursor \
	-no-feature-webengine-system-xi \
	-no-feature-webengine-system-xproto-gl \
	-no-feature-webengine-system-xtst
endif

QT5WEBENGINE_DEPENDENCIES += \
	host-bison \
	host-flex \
	host-freetype \
	host-gperf \
	host-harfbuzz \
	host-icu \
	host-ninja \
	host-nodejs \
	host-pkgconf \
	host-libjpeg \
	host-libnss \
	host-libpng \
	host-python3 \
	host-webp \
	host-zlib \
	ffmpeg \
	freetype \
	jpeg \
	lcms2 \
	libevent \
	libnss \
	libvpx \
	libxml2 \
	libxslt \
	re2 \
	snappy \
	webp

QT5WEBENGINE_CONF_OPTS += \
	-webengine-embedded-build \
	-webengine-ffmpeg \
	-webengine-icu \
	-webengine-opus \
	-webengine-webchannel \
	-webengine-webp \
	-feature-build-qtwebengine-core \
	-feature-webengine-core-support \
	-feature-webengine-system-dbus \
	-feature-webengine-system-fontconfig \
	-feature-webengine-system-freetype \
	-feature-webengine-system-glib \
	-feature-webengine-system-glibc \
	-feature-webengine-system-harfbuzz \
	-feature-webengine-system-jpeg \
	-feature-webengine-system-khr \
	-feature-webengine-system-lcms2 \
	-feature-webengine-system-libevent \
	-feature-webengine-system-libvpx \
	-feature-webengine-system-libxml2 \
	-feature-webengine-system-ninja \
	-feature-webengine-system-nss \
	-feature-webengine-system-png \
	-feature-webengine-system-re2 \
	-feature-webengine-system-snappy \
	-feature-webengine-system-zlib

QT5WEBENGINE_CONF_OPTS += \
	-no-webengine-geolocation \
	-no-webengine-kerberos \
	-no-webengine-pepper-plugins \
	-no-webengine-printing-and-pdf \
	-no-webengine-spellchecker \
	-no-webengine-webrtc \
	-no-webengine-webrtc-pipewire \
	-no-feature-webengine-developer-build \
	-no-feature-webengine-full-debug-info \
	-no-feature-webengine-native-spellchecker \
	-no-feature-webengine-noexecstack \
	-no-feature-webengine-system-minizip \
	-no-feature-webengine-system-gn

ifeq ($(BR2_PACKAGE_QT5WEBENGINE_PROPRIETARY_CODECS),y)
QT5WEBENGINE_CONF_OPTS += -webengine-proprietary-codecs
else
QT5WEBENGINE_CONF_OPTS += -no-webengine-proprietary-codecs
endif

ifeq ($(BR2_PACKAGE_QT5WEBENGINE_ALSA),y)
QT5WEBENGINE_DEPENDENCIES += alsa-lib
QT5WEBENGINE_CONF_OPTS += -webengine-alsa
else
QT5WEBENGINE_CONF_OPTS += -no-webengine-alsa
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
QT5WEBENGINE_DEPENDENCIES += pulseaudio
QT5WEBENGINE_CONF_OPTS += -webengine-pulseaudio
else
QT5WEBENGINE_CONF_OPTS += -no-webengine-pulseaudio
endif

QT5WEBENGINE_ENV = \
	PATH=$(@D)/host-bin:$(BR_PATH) \
	PKG_CONFIG_SYSROOT_DIR="/"
define QT5WEBENGINE_CREATE_HOST_PYTHON_WRAPPER
	mkdir -p $(@D)/host-bin
	sed s%@HOST_DIR@%$(HOST_DIR)%g $(QT5WEBENGINE_PKGDIR)/host-python-wrapper.in > $(@D)/host-bin/python
	chmod +x $(@D)/host-bin/python
endef
QT5WEBENGINE_PRE_CONFIGURE_HOOKS += QT5WEBENGINE_CREATE_HOST_PYTHON_WRAPPER

QT5WEBENGINE_ENV += NINJAFLAGS="-j$(PARALLEL_JOBS)"

define QT5WEBENGINE_COPY_CHROMIUM
	rm -rf $(@D)/src/3rdparty
	cp -a $(QT5WEBENGINE_CHROMIUM_DIR) $(@D)/src/3rdparty
endef
QT5WEBENGINE_POST_PATCH_HOOKS += QT5WEBENGINE_COPY_CHROMIUM

define QT5WEBENGINE_CREATE_HOST_PKG_CONFIG
	mkdir -p $(@D)/host-bin
	sed s%@HOST_DIR@%$(HOST_DIR)%g $(QT5WEBENGINE_PKGDIR)/host-pkg-config.in > $(@D)/host-bin/host-pkg-config
	chmod +x $(@D)/host-bin/host-pkg-config
endef
QT5WEBENGINE_PRE_CONFIGURE_HOOKS += QT5WEBENGINE_CREATE_HOST_PKG_CONFIG
QT5WEBENGINE_ENV += \
	GN_PKG_CONFIG_HOST=$(@D)/host-bin/host-pkg-config \
	GN_HOST_TOOLCHAIN_EXTRA_CPPFLAGS="$(HOST_CPPFLAGS)"

QT5WEBENGINE_CONF_ENV = $(QT5WEBENGINE_ENV)
QT5WEBENGINE_MAKE_ENV = $(QT5WEBENGINE_ENV)

$(eval $(qmake-package))
