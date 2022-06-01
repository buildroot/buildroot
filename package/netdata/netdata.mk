################################################################################
#
# netdata
#
################################################################################

NETDATA_VERSION = 1.33.1
NETDATA_SOURCE = netdata-v$(NETDATA_VERSION).tar.gz
NETDATA_SITE = \
	https://github.com/netdata/netdata/releases/download/v$(NETDATA_VERSION)
NETDATA_LICENSE = GPL-3.0+
NETDATA_LICENSE_FILES = LICENSE
NETDATA_CPE_ID_VENDOR = netdata
NETDATA_CONF_OPTS = \
	--disable-cloud \
	--disable-dbengine \
	--disable-ebpf \
	--disable-ml \
	--disable-unit-tests
NETDATA_DEPENDENCIES = libuv util-linux zlib

# ac_cv_prog_cc_c99 is required for BR2_USE_WCHAR=n because the C99 test
# provided by autoconf relies on wchar_t.
NETDATA_CONF_ENV = ac_cv_prog_cc_c99=-std=gnu99

ifeq ($(BR2_GCC_ENABLE_LTO),y)
NETDATA_CONF_OPTS += --enable-lto
else
NETDATA_CONF_OPTS += --disable-lto
endif

ifeq ($(BR2_PACKAGE_CUPS),y)
NETDATA_CONF_OPTS += --enable-plugin-cups
NETDATA_DEPENDENCIES += cups
else
NETDATA_CONF_OPTS += --disable-plugin-cups
endif

ifeq ($(BR2_PACKAGE_JSON_C),y)
NETDATA_CONF_OPTS += --enable-jsonc
NETDATA_DEPENDENCIES += json-c
else
NETDATA_CONF_OPTS += --disable-jsonc
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
NETDATA_CONF_OPTS += --with-libcap
NETDATA_DEPENDENCIES += libcap
else
NETDATA_CONF_OPTS += --without-libcap
endif

ifeq ($(BR2_PACKAGE_LZ4),y)
NETDATA_CONF_OPTS += --enable-compression
NETDATA_DEPENDENCIES += lz4
else
NETDATA_CONF_OPTS += --disable-compression
endif

ifeq ($(BR2_PACKAGE_NFACCT),y)
NETDATA_CONF_OPTS += --enable-plugin-nfacct
NETDATA_DEPENDENCIES += nfacct
else
NETDATA_CONF_OPTS += --disable-plugin-nfacct
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
NETDATA_CONF_OPTS += --enable-https
NETDATA_DEPENDENCIES += openssl
else
NETDATA_CONF_OPTS += --disable-https
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
NETDATA_CONF_ENV += LIBS=-latomic
endif

ifeq ($(BR2_PACKAGE_NETDATA_PROMETHEUS),y)
# Override the result of AC_PATH_PROG([CXX_BINARY], [${CXX}], [no])
# which fails because CXX is set to the full CXX binary path
NETDATA_CONF_ENV += ac_cv_path_CXX_BINARY=yes
NETDATA_CONF_OPTS += --enable-backend-prometheus-remote-write
NETDATA_DEPENDENCIES += protobuf snappy
else
NETDATA_CONF_OPTS += --disable-backend-prometheus-remote-write
endif

define NETDATA_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/netdata/S60netdata \
		$(TARGET_DIR)/etc/init.d/S60netdata
endef

$(eval $(autotools-package))
