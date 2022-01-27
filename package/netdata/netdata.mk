################################################################################
#
# netdata
#
################################################################################

NETDATA_VERSION = 1.21.1
NETDATA_SITE = $(call github,netdata,netdata,v$(NETDATA_VERSION))
NETDATA_LICENSE = GPL-3.0+
NETDATA_LICENSE_FILES = LICENSE
NETDATA_CPE_ID_VENDOR = netdata
# netdata's source code is released without a generated configure script
NETDATA_AUTORECONF = YES
NETDATA_CONF_OPTS = \
	--disable-dbengine \
	--disable-unit-tests
NETDATA_DEPENDENCIES = libuv util-linux zlib

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
