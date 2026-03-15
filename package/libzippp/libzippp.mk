################################################################################
#
# libzip
#
################################################################################

LIBZIPPP_VERSION = 7.1-1.10.1
LIBZIPPP_SOURCE = libzippp-v$(LIBZIPPP_VERSION).tar.gz
LIBZIPPP_SITE = https://github.com/ctabin/libzippp/archive/refs/tags
LIBZIPPP_LICENSE = BSD-3-Clause
LIBZIPPP_LICENSE_FILES = LICENCE
LIBZIPPP_INSTALL_STAGING = YES
LIBZIPPP_DEPENDENCIES = libzip zlib

ifeq ($(BR2_PACKAGE_BZIP2),y)
LIBZIPPP_DEPENDENCIES += bzip2
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
LIBZIPPP_DEPENDENCIES += gnutls
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBZIPPP_DEPENDENCIES += openssl
endif

ifeq ($(BR2_PACKAGE_XZ),y)
LIBZIPPP_DEPENDENCIES += xz
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
LIBZIPPP_DEPENDENCIES += zstd
endif

$(eval $(cmake-package))
