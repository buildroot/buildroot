################################################################################
#
# cpp-httplib
#
################################################################################

CPP_HTTPLIB_VERSION = 0.25.0
CPP_HTTPLIB_SITE = $(call github,yhirose,cpp-httplib,v$(CPP_HTTPLIB_VERSION))
CPP_HTTPLIB_LICENSE = MIT
CPP_HTTPLIB_LICENSE_FILES = LICENSE
CPP_HTTPLIB_CPE_ID_VENDOR = yhirose
CPP_HTTPLIB_INSTALL_STAGING = YES
CPP_HTTPLIB_CONF_OPTS = \
	-Dtest=false

# 0001-merge-commit-from-fork.patch
CPP_HTTPLIB_IGNORE_CVES += CVE-2025-46728

ifeq ($(BR2_PACKAGE_CPP_HTTPLIB_COMPILE),y)
CPP_HTTPLIB_CONF_OPTS += -Dcompile=true
CPP_HTTPLIB_DEPENDENCIES += host-python3
else
# Header only library
CPP_HTTPLIB_INSTALL_TARGET = NO
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
CPP_HTTPLIB_CONF_OPTS += -Dopenssl=enabled
CPP_HTTPLIB_DEPENDENCIES += openssl
else
CPP_HTTPLIB_CONF_OPTS += -Dopenssl=disabled
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
CPP_HTTPLIB_CONF_OPTS += -Dzlib=enabled
CPP_HTTPLIB_DEPENDENCIES += zlib
else
CPP_HTTPLIB_CONF_OPTS += -Dzlib=disabled
endif

ifeq ($(BR2_PACKAGE_BROTLI),y)
CPP_HTTPLIB_CONF_OPTS += -Dbrotli=enabled
CPP_HTTPLIB_DEPENDENCIES += brotli
else
CPP_HTTPLIB_CONF_OPTS += -Dbrotli=disabled
endif

$(eval $(meson-package))
