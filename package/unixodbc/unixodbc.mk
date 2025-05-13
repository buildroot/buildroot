################################################################################
#
# unixodbc
#
################################################################################

UNIXODBC_VERSION = 2.3.12
UNIXODBC_SOURCE = unixODBC-$(UNIXODBC_VERSION).tar.gz
UNIXODBC_SITE = http://www.unixodbc.org
UNIXODBC_INSTALL_STAGING = YES
UNIXODBC_LICENSE = LGPL-2.1+ (library), GPL-2.0+ (programs)
UNIXODBC_LICENSE_FILES = COPYING exe/COPYING
UNIXODBC_CPE_ID_VENDOR = unixodbc

# gcc-15 defaults to -std=gnu23 which introduces build failures.
# We force "-std=gnu17" for gcc version supporting it. Earlier gcc
# versions will work, since they are using the older standard.
ifeq ($(BR2_TOOLCHAIN_GCC_AT_LEAST_8),y)
UNIXODBC_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -std=gnu17"
endif
UNIXODBC_CONF_OPTS = --enable-drivers --enable-driver-conf

ifeq ($(BR2_PACKAGE_LIBEDIT),y)
UNIXODBC_CONF_OPTS += --enable-editline
UNIXODBC_DEPENDENCIES += libedit
else
UNIXODBC_CONF_OPTS += --disable-editline
endif

ifeq ($(BR2_PACKAGE_LIBICONV),y)
UNIXODBC_CONF_OPTS += --enable-iconv
UNIXODBC_DEPENDENCIES += libiconv
else
UNIXODBC_CONF_OPTS += --disable-iconv
endif

ifeq ($(BR2_PACKAGE_LIBTOOL),y)
UNIXODBC_CONF_OPTS += --without-included-ltdl
UNIXODBC_DEPENDENCIES += libtool
else
UNIXODBC_CONF_OPTS += --with-included-ltdl
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
UNIXODBC_CONF_OPTS += --enable-readline
UNIXODBC_DEPENDENCIES += readline
else
UNIXODBC_CONF_OPTS += --disable-readline
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
UNIXODBC_CONF_OPTS += --enable-threads
else
UNIXODBC_CONF_OPTS += --disable-threads
endif

$(eval $(autotools-package))
