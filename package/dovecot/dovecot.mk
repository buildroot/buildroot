################################################################################
#
# dovecot
#
################################################################################

DOVECOT_VERSION_MAJOR = 2.4
DOVECOT_VERSION = $(DOVECOT_VERSION_MAJOR).5
DOVECOT_SITE = https://dovecot.org/releases/$(DOVECOT_VERSION_MAJOR)
DOVECOT_INSTALL_STAGING = YES
DOVECOT_LICENSE = LGPL-2.1, MIT, Public Domain, BSD-3-Clause, Unicode-DFS-2015
DOVECOT_LICENSE_FILES = COPYING COPYING.LGPL COPYING.MIT
DOVECOT_CPE_ID_VENDOR = dovecot
DOVECOT_SELINUX_MODULES = dovecot

# 0001-Revert-lib-var-expand-crypt-Link-test-binary-statica.patch
DOVECOT_AUTORECONF = YES

# add host-gettext for AM_ICONV macro needed for autoreconf
DOVECOT_DEPENDENCIES = \
	host-gettext \
	host-pkgconf \
	$(if $(BR2_PACKAGE_LIBICONV),libiconv) \
	openssl \
	zlib

DOVECOT_CONF_ENV = \
	RPCGEN=false \
	i_cv_epoll_works=yes \
	i_cv_gssapi_spnego=yes \
	i_cv_posix_fallocate_works=no \
	i_cv_gmtime_max_time_t=32 \
	i_cv_mmap_plays_with_write=yes \
	i_cv_fd_passing=yes \
	lib_cv_va_copy=yes \
	lib_cv___va_copy=yes \
	lib_cv_va_val_copy=yes

DOVECOT_CONF_OPTS = --without-docs

ifeq ($(BR2_PACKAGE_DOVECOT_MYSQL)$(BR2_PACKAGE_DOVECOT_SQLITE),)
DOVECOT_CONF_OPTS += --without-sql
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
DOVECOT_CONF_OPTS += --with-bzlib
DOVECOT_DEPENDENCIES += bzip2
else
DOVECOT_CONF_OPTS += --without-bzlib
endif

ifeq ($(BR2_PACKAGE_ICU),y)
DOVECOT_CONF_OPTS += --with-icu
DOVECOT_DEPENDENCIES += icu
else
DOVECOT_CONF_OPTS += --without-icu
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
DOVECOT_CONF_OPTS += --with-libcap
DOVECOT_DEPENDENCIES += libcap
else
DOVECOT_CONF_OPTS += --without-libcap
endif

ifeq ($(BR2_PACKAGE_LIBKRB5),y)
DOVECOT_CONF_ENV += KRB5CONFIG="$(STAGING_DIR)/usr/bin/krb5-config"
DOVECOT_CONF_OPTS += --with-gssapi=yes
DOVECOT_DEPENDENCIES += libkrb5
else
DOVECOT_CONF_OPTS += --without-gssapi
endif

ifeq ($(BR2_PACKAGE_LIBSODIUM),y)
DOVECOT_CONF_OPTS += --with-sodium
DOVECOT_DEPENDENCIES += libsodium
else
DOVECOT_CONF_OPTS += --without-sodium
endif

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
DOVECOT_DEPENDENCIES += libxcrypt
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
DOVECOT_CONF_OPTS += --with-pam
DOVECOT_DEPENDENCIES += linux-pam
else
DOVECOT_CONF_OPTS += --without-pam
endif

ifeq ($(BR2_PACKAGE_OPENLDAP),y)
DOVECOT_CONF_OPTS += --with-ldap=yes
DOVECOT_DEPENDENCIES += openldap
else
DOVECOT_CONF_OPTS += --without-ldap
endif

ifeq ($(BR2_PACKAGE_PCRE2),y)
DOVECOT_CONF_OPTS += --with-pcre2
DOVECOT_DEPENDENCIES += pcre2
else
DOVECOT_CONF_OPTS += --without-pcre2
endif

ifeq ($(BR2_PACKAGE_DOVECOT_MYSQL),y)
DOVECOT_CONF_ENV += MYSQL_CONFIG="$(STAGING_DIR)/usr/bin/mysql_config"
DOVECOT_CONF_OPTS += --with-mysql
DOVECOT_DEPENDENCIES += mariadb
else
DOVECOT_CONF_OPTS += --without-mysql
endif

ifeq ($(BR2_PACKAGE_DOVECOT_POSTGRESQL),y)
DOVECOT_CONF_OPTS += --with-pgsql
DOVECOT_DEPENDENCIES += postgresql
else
DOVECOT_CONF_OPTS += --without-pgsql
endif

ifeq ($(BR2_PACKAGE_DOVECOT_SQLITE),y)
DOVECOT_CONF_OPTS += --with-sqlite
DOVECOT_DEPENDENCIES += sqlite
else
DOVECOT_CONF_OPTS += --without-sqlite
endif

ifeq ($(BR2_PACKAGE_LZ4),y)
DOVECOT_CONF_OPTS += --with-lz4
DOVECOT_DEPENDENCIES += lz4
else
DOVECOT_CONF_OPTS += --without-lz4
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
DOVECOT_CONF_OPTS += --with-zstd
DOVECOT_DEPENDENCIES += zstd
else
DOVECOT_CONF_OPTS += --without-zstd
endif

# fix paths to avoid using /usr/lib/dovecot
define DOVECOT_POST_CONFIGURE
	for i in $$(find $(@D) -name "Makefile"); do \
		$(SED) 's%^pkglibdir =.*%pkglibdir = \$$(libdir)%' $$i; \
		$(SED) 's%^pkglibexecdir =.*%pkglibexecdir = \$$(libexecdir)%' $$i; \
	done
endef

DOVECOT_POST_CONFIGURE_HOOKS += DOVECOT_POST_CONFIGURE

# dovecot installs dovecot-config in usr/lib/, therefore
# DOVECOT_CONFIG_SCRIPTS can not be used to rewrite paths
define DOVECOT_FIX_STAGING_DOVECOT_CONFIG
	$(SED) 's,^LIBDOVECOT_INCLUDE=.*$$,LIBDOVECOT_INCLUDE=\"-I$(STAGING_DIR)/usr/include/dovecot\",' $(STAGING_DIR)/usr/lib/dovecot-config
	$(SED) 's,^LIBDOVECOT=.*$$,LIBDOVECOT=\"-L$(STAGING_DIR)/usr/lib -ldovecot\",' $(STAGING_DIR)/usr/lib/dovecot-config
endef

DOVECOT_POST_INSTALL_STAGING_HOOKS += DOVECOT_FIX_STAGING_DOVECOT_CONFIG

$(eval $(autotools-package))
