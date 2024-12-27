################################################################################
#
# monit
#
################################################################################

MONIT_VERSION = 5.34.3
MONIT_SITE = https://mmonit.com/monit/dist
MONIT_LICENSE = AGPL-3.0 with OpenSSL exception
MONIT_LICENSE_FILES = COPYING
MONIT_CPE_ID_VENDOR = mmonit
MONIT_SELINUX_MODULES = monit

# Touching Makefile.am:
# 0001-configure.ac-fixes-missing-config-macro-dir.patch touches configure.ac
MONIT_AUTORECONF = YES

MONIT_CONF_ENV = \
	libmonit_cv_setjmp_available=yes \
	libmonit_cv_vsnprintf_c99_conformant=yes \
	ax_cv_check_cflags___fstack_protector_all=$(if $(BR2_TOOLCHAIN_HAS_SSP),yes,no) \
	ac_cv_ipv6=yes

MONIT_CONF_OPTS += \
	--without-pam \
	--with-largefiles

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
MONIT_DEPENDENCIES += libxcrypt
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
MONIT_CONF_ENV += LIBS=`$(PKG_CONFIG_HOST_BINARY) --libs openssl`
ifeq ($(BR2_STATIC_LIBS),y)
MONIT_CONF_OPTS += --with-ssl-static=$(STAGING_DIR)/usr
else
MONIT_CONF_OPTS += --with-ssl --with-ssl-dir=$(STAGING_DIR)/usr
endif
MONIT_DEPENDENCIES += host-pkgconf openssl
else
MONIT_CONF_OPTS += --without-ssl
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
MONIT_CONF_OPTS += --with-zlib
MONIT_DEPENDENCIES += zlib
else
MONIT_CONF_OPTS += --without-zlib
endif

$(eval $(autotools-package))
