################################################################################
#
# poco
#
################################################################################

POCO_VERSION = 1.14.2
POCO_SITE = $(call github,pocoproject,poco,poco-$(POCO_VERSION)-release)
POCO_LICENSE = BSL-1.0
POCO_LICENSE_FILES = LICENSE
POCO_CPE_ID_VENDOR = pocoproject
POCO_INSTALL_STAGING = YES

POCO_EXCLUDES = **/libpq/libpq-fs.h

POCO_DEPENDENCIES = \
	pcre2 \
	utf8proc \
	zlib \
	$(if $(BR2_PACKAGE_POCO_CRYPTO),openssl) \
	$(if $(BR2_PACKAGE_POCO_DATA_MYSQL),mariadb) \
	$(if $(BR2_PACKAGE_POCO_DATA_SQLITE),sqlite) \
	$(if $(BR2_PACKAGE_POCO_DATA_PGSQL),postgresql) \
	$(if $(BR2_PACKAGE_POCO_NETSSL_OPENSSL),openssl) \
	$(if $(BR2_PACKAGE_POCO_PDF),libpng) \
	$(if $(BR2_PACKAGE_POCO_XML),expat)

# PageCompiler and File2Page are code generators that are of no use on
# the target, and ODBC support is not wired up in Buildroot.
POCO_CONF_OPTS = \
	-DENABLE_DATA_ODBC=OFF \
	-DENABLE_PAGECOMPILER=OFF \
	-DENABLE_PAGECOMPILER_FILE2PAGE=OFF \
	-DENABLE_ACTIVERECORD=$(if $(BR2_PACKAGE_POCO_ACTIVERECORD),ON,OFF) \
	-DENABLE_ACTIVERECORD_COMPILER=$(if $(BR2_PACKAGE_POCO_ACTIVERECORD),ON,OFF) \
	-DENABLE_CPPPARSER=$(if $(BR2_PACKAGE_POCO_CPP_PARSER),ON,OFF) \
	-DENABLE_CRYPTO=$(if $(BR2_PACKAGE_POCO_CRYPTO),ON,OFF) \
	-DENABLE_DATA=$(if $(BR2_PACKAGE_POCO_DATA),ON,OFF) \
	-DENABLE_DATA_MYSQL=$(if $(BR2_PACKAGE_POCO_DATA_MYSQL),ON,OFF) \
	-DENABLE_DATA_SQLITE=$(if $(BR2_PACKAGE_POCO_DATA_SQLITE),ON,OFF) \
	-DENABLE_DATA_POSTGRESQL=$(if $(BR2_PACKAGE_POCO_DATA_PGSQL),ON,OFF) \
	-DENABLE_JSON=$(if $(BR2_PACKAGE_POCO_JSON),ON,OFF) \
	-DENABLE_JWT=$(if $(BR2_PACKAGE_POCO_JWT),ON,OFF) \
	-DENABLE_MONGODB=$(if $(BR2_PACKAGE_POCO_MONGODB),ON,OFF) \
	-DENABLE_NET=$(if $(BR2_PACKAGE_POCO_NET),ON,OFF) \
	-DENABLE_NETSSL=$(if $(BR2_PACKAGE_POCO_NETSSL_OPENSSL),ON,OFF) \
	-DENABLE_PDF=$(if $(BR2_PACKAGE_POCO_PDF),ON,OFF) \
	-DENABLE_PROMETHEUS=$(if $(BR2_PACKAGE_POCO_PROMETHEUS),ON,OFF) \
	-DENABLE_REDIS=$(if $(BR2_PACKAGE_POCO_REDIS),ON,OFF) \
	-DENABLE_UTIL=$(if $(BR2_PACKAGE_POCO_UTIL),ON,OFF) \
	-DENABLE_XML=$(if $(BR2_PACKAGE_POCO_XML),ON,OFF) \
	-DENABLE_ZIP=$(if $(BR2_PACKAGE_POCO_ZIP),ON,OFF) \
	-DPOCO_UNBUNDLED=ON

# POCO_NO_FPENVIRONMENT and POCO_NO_WSTRING are plain preprocessor
# defines, not CMake options, so they have to be passed as compiler flags.
POCO_CXXFLAGS = $(TARGET_CXXFLAGS)

ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
POCO_CXXFLAGS += -DPOCO_NO_FPENVIRONMENT -DPOCO_NO_WSTRING
endif

# architectures missing some FE_* in their fenv.h
ifeq ($(BR2_sh4a),y)
POCO_CXXFLAGS += -DPOCO_NO_FPENVIRONMENT
endif

# disable fpenvironment for soft floating point configuration
ifeq ($(BR2_SOFT_FLOAT),y)
POCO_CXXFLAGS += -DPOCO_NO_FPENVIRONMENT
endif

POCO_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(POCO_CXXFLAGS)"

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
POCO_CONF_OPTS += \
	-DCMAKE_EXE_LINKER_FLAGS=-latomic \
	-DCMAKE_SHARED_LINKER_FLAGS=-latomic
endif

$(eval $(cmake-package))
