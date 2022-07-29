################################################################################
#
# libdill
#
################################################################################

LIBDILL_VERSION = fa01648cf2a8d06e53c965b45eeacfb3ac57bd04
LIBDILL_SITE = $(call github,sustrik,libdill,$(LIBDILL_VERSION))
LIBDILL_LICENSE = MIT
LIBDILL_LICENSE_FILES = COPYING
LIBDILL_INSTALL_STAGING = YES
# Fetched from Github, with no configure script
LIBDILL_AUTORECONF = YES

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
LIBDILL_CONF_OPTS += --enable-threads
else
LIBDILL_CONF_OPTS += --disable-threads
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBDILL_DEPENDENCIES += openssl
LIBDILL_CONF_OPTS += --enable-tls
else
LIBDILL_CONF_OPTS += --disable-tls
endif

$(eval $(autotools-package))
