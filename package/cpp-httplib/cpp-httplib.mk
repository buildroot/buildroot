################################################################################
#
# cpp-httplib
#
################################################################################

CPP_HTTPLIB_VERSION = 0.19.0
CPP_HTTPLIB_SITE = $(call github,yhirose,cpp-httplib,v$(CPP_HTTPLIB_VERSION))
CPP_HTTPLIB_LICENSE = MIT
CPP_HTTPLIB_LICENSE_FILES = LICENSE
CPP_HTTPLIB_INSTALL_STAGING = YES
CPP_HTTPLIB_CONF_OPTS = \
	-Dcpp-httplib_test=false

ifeq ($(BR2_PACKAGE_CPP_HTTPLIB_COMPILE),y)
CPP_HTTPLIB_CONF_OPTS += -Dcpp-httplib_compile=true
CPP_HTTPLIB_DEPENDENCIES += host-python3
else
# Header only library
CPP_HTTPLIB_INSTALL_TARGET = NO
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
CPP_HTTPLIB_CONF_OPTS += -Dcpp-httplib_openssl=enabled
CPP_HTTPLIB_DEPENDENCIES += openssl
else
CPP_HTTPLIB_CONF_OPTS += -Dcpp-httplib_openssl=disabled
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
CPP_HTTPLIB_CONF_OPTS += -Dcpp-httplib_zlib=enabled
CPP_HTTPLIB_DEPENDENCIES += zlib
else
CPP_HTTPLIB_CONF_OPTS += -Dcpp-httplib_zlib=disabled
endif

ifeq ($(BR2_PACKAGE_BROTLI),y)
CPP_HTTPLIB_CONF_OPTS += -Dcpp-httplib_brotli=enabled
CPP_HTTPLIB_DEPENDENCIES += brotli
else
CPP_HTTPLIB_CONF_OPTS += -Dcpp-httplib_brotli=disabled
endif

$(eval $(meson-package))
