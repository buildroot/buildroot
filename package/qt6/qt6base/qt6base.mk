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
	-DFEATURE_gui=OFF \
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
	$(TARGET_MAKE_ENV) $(BR2_CMAKE) --install $(QT6BASE_BUILDDIR) --prefix $(STAGING_DIR)/usr
endef

define QT6BASE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(BR2_CMAKE) --install $(QT6BASE_BUILDDIR) --prefix $(TARGET_DIR)/usr
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
