################################################################################
#
# qt6base
#
################################################################################

QT6BASE_VERSION = $(QT6_VERSION)
QT6BASE_SITE = $(QT6_SITE)
QT6BASE_SOURCE = qtbase-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6BASE_VERSION).tar.xz

QT6BASE_LICENSE = \
	GPL-2.0+ or LGPL-3.0, \
	GPL-3.0 with exception (tools), \
	GFDL-1.3 (docs), \
	Apache-2.0, \
	BSD-3-Clause, \
	BSL-1.0, \
	MIT

QT6BASE_LICENSE_FILES = \
	LICENSES/Apache-2.0.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/BSL-1.0.txt \
	LICENSES/GFDL-1.3-no-invariants-only.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-3.0-only.txt \
	LICENSES/MIT.txt \
	LICENSES/Qt-GPL-exception-1.0.txt

QT6BASE_DEPENDENCIES = \
	host-ninja \
	host-qt6base \
	double-conversion \
	libb2 \
	pcre2 \
	zlib
QT6BASE_INSTALL_STAGING = YES

QT6BASE_CONF_OPTS = \
	-GNinja \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DFEATURE_concurrent=OFF \
	-DFEATURE_xml=OFF \
	-DFEATURE_sql=OFF \
	-DFEATURE_testlib=OFF \
	-DFEATURE_network=OFF \
	-DFEATURE_dbus=OFF \
	-DFEATURE_icu=OFF \
	-DFEATURE_glib=OFF \
	-DFEATURE_system_doubleconversion=ON \
	-DFEATURE_system_pcre2=ON \
	-DFEATURE_system_zlib=ON \
	-DFEATURE_system_libb2=ON

# x86 optimization options. While we have a BR2_X86_CPU_HAS_AVX512, it
# is not clear yet how it maps to all the avx512* options of Qt, so we
# for now keeps them disabled.
QT6BASE_CONF_OPTS += \
	-DFEATURE_sse2=$(if $(BR2_X86_CPU_HAS_SSE2),ON,OFF) \
	-DFEATURE_sse3=$(if $(BR2_X86_CPU_HAS_SSE3),ON,OFF) \
	-DFEATURE_sse4_1=$(if $(BR2_X86_CPU_HAS_SSE4),ON,OFF) \
	-DFEATURE_sse4_2=$(if $(BR2_X86_CPU_HAS_SSE42),ON,OFF) \
	-DFEATURE_ssse3=$(if $(BR2_X86_CPU_HAS_SSSE3),ON,OFF) \
	-DFEATURE_avx=$(if $(BR2_X86_CPU_HAS_AVX),ON,OFF) \
	-DFEATURE_avx2=$(if $(BR2_X86_CPU_HAS_AVX2),ON,OFF) \
	-DFEATURE_avx512bw=OFF \
	-DFEATURE_avx512cd=OFF \
	-DFEATURE_avx512dq=OFF \
	-DFEATURE_avx512er=OFF \
	-DFEATURE_avx512f=OFF \
	-DFEATURE_avx512ifma=OFF \
	-DFEATURE_avx512pf=OFF \
	-DFEATURE_avx512vbmi=OFF \
	-DFEATURE_avx512vl=OFF

define QT6BASE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(BR2_CMAKE) --build $(QT6BASE_BUILDDIR)
endef

define QT6BASE_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) DESTDIR=$(STAGING_DIR) $(BR2_CMAKE) --install $(QT6BASE_BUILDDIR)
endef

define QT6BASE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) DESTDIR=$(TARGET_DIR) $(BR2_CMAKE) --install $(QT6BASE_BUILDDIR)
endef

HOST_QT6BASE_DEPENDENCIES = \
	host-ninja \
	host-double-conversion \
	host-libb2 \
	host-pcre2 \
	host-zlib
HOST_QT6BASE_CONF_OPTS = \
	-GNinja \
	-DFEATURE_gui=OFF \
	-DFEATURE_concurrent=OFF \
	-DFEATURE_xml=ON \
	-DFEATURE_sql=OFF \
	-DFEATURE_testlib=OFF \
	-DFEATURE_network=OFF \
	-DFEATURE_dbus=OFF \
	-DFEATURE_icu=OFF \
	-DFEATURE_glib=OFF \
	-DFEATURE_system_doubleconversion=ON \
	-DFEATURE_system_libb2=ON \
	-DFEATURE_system_pcre2=ON \
	-DFEATURE_system_zlib=ON

define HOST_QT6BASE_BUILD_CMDS
	$(HOST_MAKE_ENV) $(BR2_CMAKE) --build $(HOST_QT6BASE_BUILDDIR)
endef

define HOST_QT6BASE_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(BR2_CMAKE) --install $(HOST_QT6BASE_BUILDDIR)
endef

# Conditional blocks below are ordered by alphabetic ordering of the
# BR2_PACKAGE_* option.

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
QT6BASE_CONF_OPTS += -DFEATURE_libudev=ON
QT6BASE_DEPENDENCIES += udev
else
QT6BASE_CONF_OPTS += -DFEATURE_libudev=OFF
endif

ifeq ($(BR2_PACKAGE_ICU),y)
QT6BASE_CONF_OPTS += -DFEATURE_icu=ON
QT6BASE_DEPENDENCIES += icu
else
QT6BASE_CONF_OPTS += -DFEATURE_icu=OFF
endif

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
QT6BASE_CONF_OPTS += -DFEATURE_glib=ON
QT6BASE_DEPENDENCIES += libglib2
else
QT6BASE_CONF_OPTS += -DFEATURE_glib=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_GUI),y)
QT6BASE_CONF_OPTS += \
	-DFEATURE_gui=ON \
	-DFEATURE_freetype=ON \
	-DFEATURE_vulkan=OFF
QT6BASE_DEPENDENCIES += freetype

ifeq ($(BR2_PACKAGE_QT6BASE_LINUXFB),y)
QT6BASE_CONF_OPTS += -DFEATURE_linuxfb=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_linuxfb=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_XCB),y)
QT6BASE_CONF_OPTS += \
	-DFEATURE_xcb=ON \
	-DFEATURE_xcb_xlib=ON \
	-DFEATURE_xkbcommon=ON \
	-DFEATURE_xkbcommon_x11=ON
QT6BASE_DEPENDENCIES += \
	libxcb \
	libxkbcommon \
	xcb-util-wm \
	xcb-util-image \
	xcb-util-keysyms \
	xcb-util-renderutil \
	xlib_libX11
else
QT6BASE_CONF_OPTS += -DFEATURE_xcb=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_HARFBUZZ),y)
QT6BASE_CONF_OPTS += -DFEATURE_harfbuzz=ON
ifeq ($(BR2_TOOLCHAIN_HAS_SYNC_4),y)
# system harfbuzz in case __sync for 4 bytes is supported
QT6BASE_CONF_OPTS += -DQT_USE_BUNDLED_BundledHarfbuzz=OFF
QT6BASE_DEPENDENCIES += harfbuzz
else #BR2_TOOLCHAIN_HAS_SYNC_4
# qt harfbuzz otherwise (using QAtomic instead)
QT6BASE_CONF_OPTS += -DQT_USE_BUNDLED_BundledHarfbuzz=ON
QT6BASE_LICENSE += , MIT (harfbuzz)
QT6BASE_LICENSE_FILES += src/3rdparty/harfbuzz-ng/COPYING
endif
else
QT6BASE_CONF_OPTS += -DFEATURE_harfbuzz=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_PNG),y)
QT6BASE_CONF_OPTS += -DFEATURE_png=ON -DFEATURE_system_png=ON
QT6BASE_DEPENDENCIES += libpng
else
QT6BASE_CONF_OPTS += -DFEATURE_png=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_GIF),y)
QT6BASE_CONF_OPTS += -DFEATURE_gif=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_gif=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_JPEG),y)
QT6BASE_CONF_OPTS += -DFEATURE_jpeg=ON
QT6BASE_DEPENDENCIES += jpeg
else
QT6BASE_CONF_OPTS += -DFEATURE_jpeg=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_PRINTSUPPORT),y)
QT6BASE_CONF_OPTS += -DFEATURE_printsupport=ON
ifeq ($(BR2_PACKAGE_CUPS),y)
QT6BASE_CONF_OPTS += -DFEATURE_cups=ON
QT6BASE_DEPENDENCIES += cups
else
QT6BASE_CONF_OPTS += -DFEATURE_cups=OFF
endif
else
QT6BASE_CONF_OPTS += -DFEATURE_printsupport=OFF
endif

ifeq ($(BR2_PACKAGE_LIBDRM),y)
QT6BASE_CONF_OPTS += -DFEATURE_kms=ON
QT6BASE_DEPENDENCIES += libdrm
else
QT6BASE_CONF_OPTS += -DFEATURE_kms=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_FONTCONFIG),y)
QT6BASE_CONF_OPTS += -DFEATURE_fontconfig=ON
QT6BASE_DEPENDENCIES += fontconfig
else
QT6BASE_CONF_OPTS += -DFEATURE_fontconfig=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_WIDGETS),y)
QT6BASE_CONF_OPTS += -DFEATURE_widgets=ON

# only enable gtk support if libgtk3 X11 backend is enabled
ifeq ($(BR2_PACKAGE_LIBGTK3)$(BR2_PACKAGE_LIBGTK3_X11),yy)
QT6BASE_CONF_OPTS += -DFEATURE_gtk3=ON
QT6BASE_DEPENDENCIES += libgtk3
else
QT6BASE_CONF_OPTS += -DFEATURE_gtk3=OFF
endif

else
QT6BASE_CONF_OPTS += -DFEATURE_widgets=OFF
endif

ifeq ($(BR2_PACKAGE_LIBINPUT),y)
QT6BASE_CONF_OPTS += -DFEATURE_libinput=ON
QT6BASE_DEPENDENCIES += libinput
else
QT6BASE_CONF_OPTS += -DFEATURE_libinput=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_TSLIB),y)
QT6BASE_CONF_OPTS += -DFEATURE_tslib=ON
QT6BASE_DEPENDENCIES += tslib
else
QT6BASE_CONF_OPTS += -DFEATURE_tslib=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_EGLFS),y)
QT6BASE_CONF_OPTS += -DFEATURE_egl=ON -DFEATURE_eglfs=ON
QT6BASE_DEPENDENCIES += libegl libgbm
else
QT6BASE_CONF_OPTS += -DFEATURE_eglfs=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_OPENGL_DESKTOP),y)
QT6BASE_CONF_OPTS += -DFEATURE_opengl=ON -DFEATURE_opengl_desktop=ON
QT6BASE_DEPENDENCIES += libgl
else ifeq ($(BR2_PACKAGE_QT6BASE_OPENGL_ES2),y)
QT6BASE_CONF_OPTS += -DFEATURE_opengl=ON -DFEATURE_opengles2=ON
QT6BASE_DEPENDENCIES += libgles
else
QT6BASE_CONF_OPTS += -DFEATURE_opengl=OFF -DINPUT_opengl=no
endif

else
QT6BASE_CONF_OPTS += -DFEATURE_gui=OFF
endif

QT6BASE_DEFAULT_QPA = $(call qstrip,$(BR2_PACKAGE_QT6BASE_DEFAULT_QPA))
QT6BASE_CONF_OPTS += $(if $(QT6BASE_DEFAULT_QPA),-DQT_QPA_DEFAULT_PLATFORM=$(QT6BASE_DEFAULT_QPA))

ifeq ($(BR2_PACKAGE_OPENSSL),y)
QT6BASE_CONF_OPTS += -DINPUT_openssl=yes
QT6BASE_DEPENDENCIES += openssl
else
QT6BASE_CONF_OPTS += -DINPUT_openssl=no
endif

ifeq ($(BR2_PACKAGE_QT6BASE_CONCURRENT),y)
QT6BASE_CONF_OPTS += -DFEATURE_concurrent=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_concurrent=OFF
endif

# We need host-qt6base with D-Bus support, otherwise: "the tool
# "Qt6::qdbuscpp2xml" was not found in the Qt6DBusTools package."
ifeq ($(BR2_PACKAGE_QT6BASE_DBUS),y)
QT6BASE_CONF_OPTS += -DFEATURE_dbus=ON -DINPUT_dbus=linked
QT6BASE_DEPENDENCIES += dbus
HOST_QT6BASE_CONF_OPTS += -DFEATURE_dbus=ON
HOST_QT6BASE_DEPENDENCIES += host-dbus
else
QT6BASE_CONF_OPTS += -DFEATURE_dbus=OFF
HOST_QT6BASE_CONF_OPTS += -DFEATURE_dbus=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_NETWORK),y)
QT6BASE_CONF_OPTS += -DFEATURE_network=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_network=OFF
endif

# Qt6 SQL Plugins
ifeq ($(BR2_PACKAGE_QT6BASE_SQL),y)
QT6BASE_CONF_OPTS += -DFEATURE_sql=ON
QT6BASE_CONF_OPTS += -DFEATURE_sql_db2=OFF -DFEATURE_sql_ibase=OFF -DFEATURE_sql_oci=OFF -DFEATURE_sql_odbc=OFF

ifeq ($(BR2_PACKAGE_QT6BASE_MYSQL),y)
QT6BASE_CONF_OPTS += -DFEATURE_sql_mysql=ON
QT6BASE_DEPENDENCIES += mysql
else
QT6BASE_CONF_OPTS += -DFEATURE_sql_mysql=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_PSQL),y)
QT6BASE_CONF_OPTS += -DFEATURE_sql_psql=ON
QT6BASE_DEPENDENCIES += postgresql
else
QT6BASE_CONF_OPTS += -DFEATURE_sql_psql=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_SQLITE),y)
QT6BASE_CONF_OPTS += -DFEATURE_sql_sqlite=ON -DFEATURE_system_sqlite=ON
QT6BASE_DEPENDENCIES += sqlite
else
QT6BASE_CONF_OPTS += -DFEATURE_sql_sqlite=OFF
endif

else
QT6BASE_CONF_OPTS += -DFEATURE_sql=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_SYSLOG),y)
QT6BASE_CONF_OPTS += -DFEATURE_syslog=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_syslog=OFF
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
QT6BASE_CONF_OPTS += -DFEATURE_journald=ON
QT6BASE_DEPENDENCIES += systemd
else
QT6BASE_CONF_OPTS += -DFEATURE_journald=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_TEST),y)
QT6BASE_CONF_OPTS += -DFEATURE_testlib=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_testlib=OFF
endif

ifeq ($(BR2_PACKAGE_QT6BASE_XML),y)
QT6BASE_CONF_OPTS += -DFEATURE_xml=ON
else
QT6BASE_CONF_OPTS += -DFEATURE_xml=OFF
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
QT6BASE_CONF_OPTS += -DFEATURE_zstd=ON
QT6BASE_DEPENDENCIES += zstd
else
QT6BASE_CONF_OPTS += -DFEATURE_zstd=OFF
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))
