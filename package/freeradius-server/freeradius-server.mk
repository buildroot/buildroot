################################################################################
#
# freeradius-server
#
################################################################################

FREERADIUS_SERVER_VERSION = 3.2.0
FREERADIUS_SERVER_SOURCE = \
	freeradius-server-$(FREERADIUS_SERVER_VERSION).tar.bz2
FREERADIUS_SERVER_SITE = ftp://ftp.freeradius.org/pub/freeradius
FREERADIUS_SERVER_LICENSE = GPL-2.0
FREERADIUS_SERVER_LICENSE_FILES = COPYRIGHT
FREERADIUS_SERVER_CPE_ID_VENDOR = freeradius
FREERADIUS_SERVER_CPE_ID_PRODUCT = freeradius
FREERADIUS_SERVER_DEPENDENCIES = libtalloc
FREERADIUS_SERVER_AUTORECONF = YES

# We're patching src/modules/rlm_krb5/configure.ac
define FREERADIUS_SERVER_RUN_KRB5_AUTOCONF
	cd $(@D)/src/modules/rlm_krb5; $(AUTOCONF) -I$(@D)
endef
FREERADIUS_SERVER_PRE_CONFIGURE_HOOKS += FREERADIUS_SERVER_RUN_KRB5_AUTOCONF

# some compiler checks are not supported while cross compiling.
# instead of removing those checks, we cache the answers
FREERADIUS_SERVER_CONF_OPTS += \
	ax_cv_cc_bounded_attribute=no \
	ax_cv_cc_builtin_bswap64=no \
	ax_cv_cc_builtin_choose_expr=no \
	ax_cv_cc_builtin_types_compatible_p=no

# Some paths are looked up in $PATH but used on the target.
# Set them explicitly so they are still valid if it's in some other
# place on the host. Note that some of those don't necessarily exist
# on the target - in that case, the script will simply fail to work.
# Note that some paths are actually used during the build, those
# shouldn't be set explicitly here!
FREERADIUS_SERVER_CONF_OPTS += \
	ac_cv_path_RUSERS=/usr/bin/rusers \
	ac_cv_path_SNMPGET=/usr/bin/snmpget \
	ac_cv_path_SNMPWALK=/usr/bin/snmpwalk

# Modules for which we don't have the dependencies must be disabled
# explicitly, to avoid that they're searched on the host.
FREERADIUS_SERVER_CONF_OPTS += \
	--without-rlm_eap_ike \
	--without-rlm_eap_tnc \
	--without-rlm_mschap \
	--without-rlm_perl \
	--without-rlm_realm \
	--without-rlm_sql_iodbc \
	--without-rlm_sql_oracle \
	--without-rlm_sql_freetds \
	--without-rlm_yubikey

ifeq ($(BR2_PACKAGE_COLLECTD),y)
FREERADIUS_SERVER_CONF_OPTS += --with-collectdclient
FREERADIUS_SERVER_DEPENDENCIES += collectd
else
FREERADIUS_SERVER_CONF_OPTS += --without-collectdclient
endif

ifeq ($(BR2_PACKAGE_GDBM),y)
FREERADIUS_SERVER_CONF_OPTS += \
	--with-rlm_counter \
	--with-rlm_ippool
FREERADIUS_SERVER_DEPENDENCIES += gdbm
else
FREERADIUS_SERVER_CONF_OPTS += \
	--without-rlm_counter \
	--without-rlm_ippool
endif

ifeq ($(BR2_PACKAGE_JSON_C)$(BR2_PACKAGE_LIBCURL),yy)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_rest
FREERADIUS_SERVER_DEPENDENCIES += json-c libcurl
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_rest
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
FREERADIUS_SERVER_CONF_OPTS += --with-libcap
FREERADIUS_SERVER_DEPENDENCIES += libcap
else
FREERADIUS_SERVER_CONF_OPTS += --without-libcap
endif

ifeq ($(BR2_PACKAGE_LIBKRB5),y)
FREERADIUS_SERVER_CONF_OPTS += \
	ac_cv_path_krb5_config=$(STAGING_DIR)/usr/bin/krb5-config \
	--with-rlm_krb5
FREERADIUS_SERVER_DEPENDENCIES += libkrb5
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_krb5
endif

ifeq ($(BR2_PACKAGE_LIBPCAP),y)
FREERADIUS_SERVER_CONF_OPTS += --with-pcap
FREERADIUS_SERVER_DEPENDENCIES += libpcap
else
FREERADIUS_SERVER_CONF_OPTS += --without-pcap
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_pam
FREERADIUS_SERVER_DEPENDENCIES += linux-pam
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_pam
endif

ifeq ($(BR2_PACKAGE_OPENLDAP),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_ldap
FREERADIUS_SERVER_DEPENDENCIES += openldap
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_ldap
endif

ifeq ($(BR2_PACKAGE_MEMCACHED),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_cache_memcached
FREERADIUS_SERVER_DEPENDENCIES += memcached
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_cache_memcached
endif

ifeq ($(BR2_PACKAGE_MYSQL),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_sql_mysql
FREERADIUS_SERVER_DEPENDENCIES += mysql
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_sql_mysql
endif

ifeq ($(BR2_PACKAGE_PCRE),y)
FREERADIUS_SERVER_CONF_OPTS += --with-pcre
FREERADIUS_SERVER_DEPENDENCIES += pcre
else
FREERADIUS_SERVER_CONF_OPTS += --without-pcre
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_python
FREERADIUS_SERVER_DEPENDENCIES += python3
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_python
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
FREERADIUS_SERVER_CONF_OPTS += --with-readline
FREERADIUS_SERVER_DEPENDENCIES += readline
else
FREERADIUS_SERVER_CONF_OPTS += --without-readline
endif

ifeq ($(BR2_PACKAGE_REDIS),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_redis --with-rlm_rediswho
FREERADIUS_SERVER_DEPENDENCIES += redis
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_redis --without-rlm_rediswho
endif

ifeq ($(BR2_PACKAGE_SQLITE),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_sql_sqlite
FREERADIUS_SERVER_DEPENDENCIES += sqlite
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_sql_sqlite
endif

ifeq ($(BR2_PACKAGE_UNIXODBC),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_sql_unixodbc
FREERADIUS_SERVER_DEPENDENCIES += unixodbc
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_sql_unixodbc
endif

ifeq ($(BR2_PACKAGE_POSTGRESQL),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_sql_postgresql
FREERADIUS_SERVER_DEPENDENCIES += postgresql
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_sql_postgresql
endif

ifeq ($(BR2_PACKAGE_LIBOPENSSL),y)
FREERADIUS_SERVER_DEPENDENCIES += openssl
FREERADIUS_SERVER_CONF_OPTS += \
	--with-openssl \
	--with-rlm_eap \
	--with-rlm_eap_pwd
else
FREERADIUS_SERVER_CONF_OPTS += \
	--without-openssl \
	--without-rlm_eap \
	--without-rlm_eap_pwd
endif

ifeq ($(BR2_PACKAGE_PCRE),y)
FREERADIUS_SERVER_CONF_OPTS += --with-pcre
FREERADIUS_SERVER_DEPENDENCIES += pcre
else
FREERADIUS_SERVER_CONF_OPTS += --without-pcre
endif

ifeq ($(BR2_PACKAGE_RUBY),y)
FREERADIUS_SERVER_CONF_OPTS += --with-rlm_ruby
FREERADIUS_SERVER_DEPENDENCIES += ruby
else
FREERADIUS_SERVER_CONF_OPTS += --without-rlm_ruby
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
FREERADIUS_SERVER_CONF_OPTS += --with-systemd
FREERADIUS_SERVER_DEPENDENCIES += systemd
else
FREERADIUS_SERVER_CONF_OPTS += --without-systemd
endif

# TARGET_DIR is set to empty to avoid creation of symlinks in hardcoded host directories
# freeradius Makefile does not support an alternate DESTDIR, instead it uses the magic $(R) variable
FREERADIUS_SERVER_MAKE_ENV = R=$(TARGET_DIR) TARGET_DIR=""

# use MAKE1 because make install does not support parallel build
FREERADIUS_SERVER_MAKE = $(MAKE1)

define FREERADIUS_SERVER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/freeradius-server/radiusd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/radiusd.service
endef

$(eval $(autotools-package))
