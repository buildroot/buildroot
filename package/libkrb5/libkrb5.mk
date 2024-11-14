################################################################################
#
# libkrb5
#
################################################################################

LIBKRB5_VERSION_MAJOR = 1.21
LIBKRB5_VERSION = $(LIBKRB5_VERSION_MAJOR).3
LIBKRB5_SITE = https://web.mit.edu/kerberos/dist/krb5/$(LIBKRB5_VERSION_MAJOR)
LIBKRB5_SOURCE = krb5-$(LIBKRB5_VERSION).tar.gz
LIBKRB5_SUBDIR = src
LIBKRB5_LICENSE = MIT, BSD-2-Clause, BSD-3-Clause, BSD-4-Clause, others
LIBKRB5_LICENSE_FILES = NOTICE
LIBKRB5_CPE_ID_VENDOR = mit
LIBKRB5_CPE_ID_PRODUCT = kerberos_5
LIBKRB5_DEPENDENCIES = host-bison $(TARGET_NLS_DEPENDENCIES)
LIBKRB5_INSTALL_STAGING = YES

# The configure script uses AC_TRY_RUN tests to check for those values,
# which doesn't work in a cross-compilation scenario. Therefore,
# we feed the configure script with the correct answer for those tests
LIBKRB5_CONF_ENV = \
	ac_cv_printf_positional=yes \
	ac_cv_func_regcomp=yes \
	krb5_cv_attr_constructor_destructor=yes,yes \
	LIBS=$(TARGET_NLS_LIBS)

# Never use the host packages
LIBKRB5_CONF_OPTS = \
	--without-system-db \
	--without-system-et \
	--without-system-ss \
	--without-system-verto \
	--without-tcl \
	--disable-rpath

# libkrb5 has some assembly function that is not present in Thumb mode:
# Error: selected processor does not support `mcr p15,0,r2,c7,c10,5' in Thumb mode
# so, we deactivate Thumb mode
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
LIBKRB5_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -marm"
endif

# Enabling static and shared at the same time is not supported
ifeq ($(BR2_SHARED_STATIC_LIBS),y)
LIBKRB5_CONF_OPTS += --disable-static
endif

ifeq ($(BR2_PACKAGE_OPENLDAP),y)
LIBKRB5_CONF_OPTS += --with-ldap
LIBKRB5_DEPENDENCIES += openldap
else
LIBKRB5_CONF_OPTS += --without-ldap
endif

ifeq ($(BR2_PACKAGE_LIBOPENSSL),y)
LIBKRB5_CONF_OPTS += \
	--enable-pkinit \
	--with-crypto-impl=openssl \
	--with-spake-openssl \
	--with-tls-impl=openssl
LIBKRB5_DEPENDENCIES += openssl
else
LIBKRB5_CONF_OPTS += \
	--disable-pkinit \
	--with-crypto-impl=builtin \
	--without-spake-openssl \
	--without-tls-impl
endif

ifeq ($(BR2_PACKAGE_LIBEDIT),y)
LIBKRB5_CONF_OPTS += --with-libedit
LIBKRB5_DEPENDENCIES += host-pkgconf libedit
else
LIBKRB5_CONF_OPTS += --without-libedit
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
LIBKRB5_CONF_OPTS += --with-readline
LIBKRB5_DEPENDENCIES += readline
else
LIBKRB5_CONF_OPTS += --without-readline
endif

ifneq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
LIBKRB5_CONF_OPTS += --disable-thread-support
endif

$(eval $(autotools-package))
