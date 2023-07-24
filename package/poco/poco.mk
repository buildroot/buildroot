################################################################################
#
# poco
#
################################################################################

POCO_VERSION = 1.12.4
POCO_SITE = $(call github,pocoproject,poco,poco-$(POCO_VERSION)-release)
POCO_LICENSE = BSL-1.0
POCO_LICENSE_FILES = LICENSE
POCO_CPE_ID_VENDOR = pocoproject
POCO_INSTALL_STAGING = YES

POCO_DEPENDENCIES = \
	pcre2 \
	zlib \
	$(if $(BR2_PACKAGE_POCO_CRYPTO),openssl) \
	$(if $(BR2_PACKAGE_POCO_DATA_MYSQL),mysql) \
	$(if $(BR2_PACKAGE_POCO_DATA_SQLITE),sqlite) \
	$(if $(BR2_PACKAGE_POCO_DATA_PGSQL),postgresql) \
	$(if $(BR2_PACKAGE_POCO_NETSSL_OPENSSL),openssl) \
	$(if $(BR2_PACKAGE_POCO_XML),expat)

POCO_OMIT = \
	Data/ODBC \
	PageCompiler \
	$(if $(BR2_PACKAGE_POCO_ACTIVERECORD),,ActiveRecord) \
	$(if $(BR2_PACKAGE_POCO_CPP_PARSER),,CppParser) \
	$(if $(BR2_PACKAGE_POCO_CRYPTO),,Crypto) \
	$(if $(BR2_PACKAGE_POCO_DATA),,Data) \
	$(if $(BR2_PACKAGE_POCO_DATA_MYSQL),,Data/MySQL) \
	$(if $(BR2_PACKAGE_POCO_DATA_SQLITE),,Data/SQLite) \
	$(if $(BR2_PACKAGE_POCO_DATA_PGSQL),,Data/PostgreSQL) \
	$(if $(BR2_PACKAGE_POCO_JSON),,JSON) \
	$(if $(BR2_PACKAGE_POCO_JWT),,JWT) \
	$(if $(BR2_PACKAGE_POCO_MONGODB),,MongoDB) \
	$(if $(BR2_PACKAGE_POCO_NET),,Net) \
	$(if $(BR2_PACKAGE_POCO_NETSSL_OPENSSL),,NetSSL_OpenSSL) \
	$(if $(BR2_PACKAGE_POCO_PDF),,PDF) \
	$(if $(BR2_PACKAGE_POCO_PROMETHEUS),,Prometheus) \
	$(if $(BR2_PACKAGE_POCO_REDIS),,Redis) \
	$(if $(BR2_PACKAGE_POCO_UTIL),,Util) \
	$(if $(BR2_PACKAGE_POCO_XML),,XML) \
	$(if $(BR2_PACKAGE_POCO_ZIP),,Zip)

ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
POCO_CONF_OPTS += --no-fpenvironment --no-wstring
endif

# architectures missing some FE_* in their fenv.h
ifeq ($(BR2_sh4a)$(BR2_nios2),y)
POCO_CONF_OPTS += --no-fpenvironment
endif

# disable fpenvironment for soft floating point configuration
ifeq ($(BR2_SOFT_FLOAT),y)
POCO_CONF_OPTS += --no-fpenvironment
endif

ifeq ($(BR2_STATIC_LIBS),y)
POCO_MAKE_TARGET = static_release
else ifeq ($(BR2_SHARED_LIBS),y)
POCO_MAKE_TARGET = shared_release
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
POCO_MAKE_TARGET = all_release
endif

POCO_LDFLAGS=$(TARGET_LDFLAGS)
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
POCO_LDFLAGS += -latomic
endif

define POCO_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) ./configure \
		--config=Linux \
		--prefix=/usr \
		--cflags=-std=c++14 \
		--ldflags="$(POCO_LDFLAGS)" \
		--omit="$(POCO_OMIT)" \
		$(POCO_CONF_OPTS) \
		--unbundled \
		--no-tests \
		--no-samples)
endef

# Use $(MAKE1) to avoid failures on heavilly parallel machines (e.g. -j25)
define POCO_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) POCO_TARGET_OSARCH=$(ARCH) CROSS_COMPILE=$(TARGET_CROSS) \
		POCO_MYSQL_INCLUDE=$(STAGING_DIR)/usr/include/mysql \
		POCO_MYSQL_LIB=$(STAGING_DIR)/usr/lib/mysql \
		POCO_PGSQL_INCLUDE=$(STAGING_DIR)/usr/include/postgresql \
		POCO_PGSQL_LIB=$(STAGING_DIR)/usr/lib/postgresql \
		DEFAULT_TARGET=$(POCO_MAKE_TARGET) -C $(@D)
endef

define POCO_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(STAGING_DIR) POCO_TARGET_OSARCH=$(ARCH) \
		DEFAULT_TARGET=$(POCO_MAKE_TARGET) install -C $(@D)
endef

define POCO_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) POCO_TARGET_OSARCH=$(ARCH) \
		DEFAULT_TARGET=$(POCO_MAKE_TARGET) install -C $(@D)
endef

$(eval $(generic-package))
