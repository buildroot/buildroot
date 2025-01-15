################################################################################
#
# php
#
################################################################################

PHP_VERSION = 8.3.15
PHP_SITE = https://www.php.net/distributions
PHP_SOURCE = php-$(PHP_VERSION).tar.xz
PHP_INSTALL_STAGING = YES
PHP_INSTALL_STAGING_OPTS = INSTALL_ROOT=$(STAGING_DIR) install
PHP_INSTALL_TARGET_OPTS = INSTALL_ROOT=$(TARGET_DIR) install
PHP_DEPENDENCIES = host-pkgconf pcre2
PHP_LICENSE = PHP-3.01
PHP_LICENSE_FILES = LICENSE
PHP_CPE_ID_VENDOR = php

PHP_CONF_OPTS = \
	--mandir=/usr/share/man \
	--infodir=/usr/share/info \
	--with-config-file-scan-dir=/etc/php.d \
	--disable-all \
	--with-external-pcre \
	--without-pear \
	--with-config-file-path=/etc \
	--disable-phpdbg \
	--disable-rpath
PHP_CONF_ENV = \
	EXTRA_LIBS="$(PHP_EXTRA_LIBS)"

ifeq ($(BR2_STATIC_LIBS),y)
PHP_CONF_ENV += LIBS="$(PHP_STATIC_LIBS)"
endif

ifeq ($(BR2_STATIC_LIBS)$(BR2_TOOLCHAIN_HAS_THREADS),yy)
PHP_STATIC_LIBS += -lpthread
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
PHP_EXTRA_LIBS += -latomic
endif

ifeq ($(BR2_PACKAGE_LIBUCONTEXT),y)
PHP_DEPENDENCIES += libucontext
PHP_EXTRA_LIBS += -lucontext
endif

ifeq ($(call qstrip,$(BR2_TARGET_LOCALTIME)),)
PHP_LOCALTIME = UTC
else
# Not q-stripping this value, as we need quotes in the php.ini file
PHP_LOCALTIME = $(BR2_TARGET_LOCALTIME)
endif

# PHP can't be AUTORECONFed the standard way unfortunately
PHP_DEPENDENCIES += host-autoconf host-automake host-libtool
define PHP_BUILDCONF
	cd $(@D) ; $(TARGET_MAKE_ENV) ./buildconf --force
endef
PHP_PRE_CONFIGURE_HOOKS += PHP_BUILDCONF

ifeq ($(BR2_ENDIAN),"BIG")
PHP_CONF_ENV += ac_cv_c_bigendian_php=yes
else
PHP_CONF_ENV += ac_cv_c_bigendian_php=no
endif
PHP_CONFIG_SCRIPTS = php-config

PHP_CFLAGS = $(TARGET_CFLAGS)
PHP_CXXFLAGS = $(TARGET_CXXFLAGS)

# The OPcache extension isn't cross-compile friendly
# Throw some defines here to avoid patching heavily
ifeq ($(BR2_PACKAGE_PHP_EXT_OPCACHE),y)
PHP_CONF_OPTS += --enable-opcache --disable-opcache-jit
PHP_CONF_ENV += ac_cv_func_mprotect=yes
PHP_CFLAGS += \
	-DHAVE_SHM_IPC \
	-DHAVE_SHM_MMAP_ANON \
	-DHAVE_SHM_MMAP_ZERO \
	-DHAVE_SHM_MMAP_POSIX \
	-DHAVE_SHM_MMAP_FILE
endif

# We need to force dl "detection"
ifeq ($(BR2_STATIC_LIBS),)
PHP_CONF_ENV += ac_cv_func_dlopen=yes ac_cv_lib_dl_dlopen=yes
PHP_EXTRA_LIBS += -ldl
else
PHP_CONF_ENV += ac_cv_func_dlopen=no ac_cv_lib_dl_dlopen=no
endif

# php has some assembly function that is not present in Thumb mode:
# Error: selected processor does not support `umlal r2,r1,r0,r3' in Thumb mode
# so, we deactivate Thumb mode
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
PHP_CFLAGS += -marm
endif

PHP_CONF_OPTS += $(if $(BR2_PACKAGE_PHP_SAPI_CLI),--enable-cli,--disable-cli)
PHP_CONF_OPTS += $(if $(BR2_PACKAGE_PHP_SAPI_CGI),--enable-cgi,--disable-cgi)
PHP_CONF_OPTS += $(if $(BR2_PACKAGE_PHP_SAPI_FPM),--enable-fpm,--disable-fpm)

ifeq ($(BR2_PACKAGE_PHP_SAPI_APACHE),y)
PHP_DEPENDENCIES += apache
PHP_CONF_OPTS += --with-apxs2=$(STAGING_DIR)/usr/bin/apxs

# Enable thread safety option if Apache MPM is event or worker
ifeq ($(BR2_PACKAGE_APACHE_MPM_EVENT)$(BR2_PACKAGE_APACHE_MPM_WORKER),y)
PHP_CONF_OPTS += --enable-zts
endif
endif

### Extensions
PHP_CONF_OPTS += \
	$(if $(BR2_PACKAGE_PHP_EXT_SOCKETS),--enable-sockets) \
	$(if $(BR2_PACKAGE_PHP_EXT_POSIX),--enable-posix) \
	$(if $(BR2_PACKAGE_PHP_EXT_SESSION),--enable-session) \
	$(if $(BR2_PACKAGE_PHP_EXT_DOM),--enable-dom) \
	$(if $(BR2_PACKAGE_PHP_EXT_SIMPLEXML),--enable-simplexml) \
	$(if $(BR2_PACKAGE_PHP_EXT_SOAP),--enable-soap) \
	$(if $(BR2_PACKAGE_PHP_EXT_XML),--enable-xml) \
	$(if $(BR2_PACKAGE_PHP_EXT_XMLREADER),--enable-xmlreader) \
	$(if $(BR2_PACKAGE_PHP_EXT_XMLWRITER),--enable-xmlwriter) \
	$(if $(BR2_PACKAGE_PHP_EXT_EXIF),--enable-exif) \
	$(if $(BR2_PACKAGE_PHP_EXT_FTP),--enable-ftp) \
	$(if $(BR2_PACKAGE_PHP_EXT_TOKENIZER),--enable-tokenizer) \
	$(if $(BR2_PACKAGE_PHP_EXT_PCNTL),--enable-pcntl) \
	$(if $(BR2_PACKAGE_PHP_EXT_SHMOP),--enable-shmop) \
	$(if $(BR2_PACKAGE_PHP_EXT_SYSVMSG),--enable-sysvmsg) \
	$(if $(BR2_PACKAGE_PHP_EXT_SYSVSEM),--enable-sysvsem) \
	$(if $(BR2_PACKAGE_PHP_EXT_SYSVSHM),--enable-sysvshm) \
	$(if $(BR2_PACKAGE_PHP_EXT_ZIP),--with-zip) \
	$(if $(BR2_PACKAGE_PHP_EXT_CTYPE),--enable-ctype) \
	$(if $(BR2_PACKAGE_PHP_EXT_FILTER),--enable-filter) \
	$(if $(BR2_PACKAGE_PHP_EXT_CALENDAR),--enable-calendar) \
	$(if $(BR2_PACKAGE_PHP_EXT_FILEINFO),--enable-fileinfo) \
	$(if $(BR2_PACKAGE_PHP_EXT_BCMATH),--enable-bcmath) \
	$(if $(BR2_PACKAGE_PHP_EXT_PHAR),--enable-phar)

ifeq ($(BR2_PACKAGE_PHP_EXT_LIBARGON2),y)
PHP_CONF_OPTS += --with-password-argon2=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += libargon2
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_LIBSODIUM),y)
PHP_CONF_OPTS += --with-sodium=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += libsodium
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_MBSTRING),y)
PHP_CONF_OPTS += --enable-mbstring
PHP_DEPENDENCIES += oniguruma
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_OPENSSL),y)
PHP_CONF_OPTS += --with-openssl=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += openssl
# openssl needs zlib, but the configure script forgets to link against
# it causing detection failures with static linking
PHP_STATIC_LIBS += `$(PKG_CONFIG_HOST_BINARY) --libs openssl`
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_LIBXML2),y)
PHP_CONF_ENV += php_cv_libxml_build_works=yes
PHP_CONF_OPTS += --with-libxml
PHP_DEPENDENCIES += libxml2
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_ZIP),y)
PHP_DEPENDENCIES += libzip
endif

ifneq ($(BR2_PACKAGE_PHP_EXT_ZLIB)$(BR2_PACKAGE_PHP_EXT_ZIP),)
PHP_CONF_OPTS += --with-zlib=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += zlib
else
PHP_CONF_OPTS += --disable-mysqlnd_compression_support
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_GETTEXT),y)
PHP_CONF_OPTS += --with-gettext=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += $(TARGET_NLS_DEPENDENCIES)
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_ICONV),y)
ifeq ($(BR2_PACKAGE_LIBICONV),y)
PHP_CONF_OPTS += --with-iconv=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += libiconv
else
PHP_CONF_OPTS += --with-iconv
endif
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_INTL),y)
PHP_CONF_OPTS += --enable-intl
PHP_DEPENDENCIES += icu
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_GMP),y)
PHP_CONF_OPTS += --with-gmp=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += gmp
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_READLINE),y)
PHP_CONF_OPTS += --with-readline=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += readline
endif

### Native SQL extensions
ifeq ($(BR2_PACKAGE_PHP_EXT_MYSQLI),y)
PHP_CONF_OPTS += --with-mysqli
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_PGSQL),y)
PHP_CONF_OPTS += --with-pgsql=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += postgresql
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_SQLITE),y)
PHP_CONF_OPTS += --with-sqlite3=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += sqlite
PHP_STATIC_LIBS += `$(PKG_CONFIG_HOST_BINARY) --libs sqlite3`
endif

### PDO
ifeq ($(BR2_PACKAGE_PHP_EXT_PDO),y)
PHP_CONF_OPTS += --enable-pdo
ifeq ($(BR2_PACKAGE_PHP_EXT_PDO_SQLITE),y)
PHP_CONF_OPTS += --with-pdo-sqlite=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += sqlite
PHP_CFLAGS += -DSQLITE_OMIT_LOAD_EXTENSION
endif
ifeq ($(BR2_PACKAGE_PHP_EXT_PDO_MYSQL),y)
PHP_CONF_OPTS += --with-pdo-mysql
endif
ifeq ($(BR2_PACKAGE_PHP_EXT_PDO_POSTGRESQL),y)
PHP_CONF_OPTS += --with-pdo-pgsql=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += postgresql
endif
ifeq ($(BR2_PACKAGE_PHP_EXT_PDO_UNIXODBC),y)
PHP_CONF_OPTS += --with-pdo-odbc=unixODBC,$(STAGING_DIR)/usr
PHP_DEPENDENCIES += unixodbc
endif
endif

ifneq ($(BR2_PACKAGE_PHP_EXT_MYSQLI)$(BR2_PACKAGE_PHP_EXT_PDO_MYSQL),)
# Set default MySQL unix socket to what the MySQL server is using by default
PHP_CONF_OPTS += --with-mysql-sock=$(MYSQL_SOCKET)
endif

define PHP_DISABLE_VALGRIND
	$(SED) '/^#define HAVE_VALGRIND/d' $(@D)/main/php_config.h
endef
PHP_POST_CONFIGURE_HOOKS += PHP_DISABLE_VALGRIND

ifeq ($(BR2_PACKAGE_PCRE2_JIT),y)
PHP_CONF_OPTS += --with-pcre-jit=yes
PHP_CONF_ENV += ac_cv_have_pcre2_jit=yes
else
PHP_CONF_OPTS += --with-pcre-jit=no
PHP_CONF_ENV += ac_cv_have_pcre2_jit=no
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_CURL),y)
PHP_CONF_OPTS += --with-curl
PHP_DEPENDENCIES += libcurl
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_XSL),y)
PHP_CONF_OPTS += --with-xsl=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += libxslt
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_BZIP2),y)
PHP_CONF_OPTS += --with-bz2=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += bzip2
endif

### DBA
ifeq ($(BR2_PACKAGE_PHP_EXT_DBA),y)
PHP_CONF_OPTS += --enable-dba
ifneq ($(BR2_PACKAGE_PHP_EXT_DBA_CDB),y)
PHP_CONF_OPTS += --without-cdb
endif
ifneq ($(BR2_PACKAGE_PHP_EXT_DBA_FLAT),y)
PHP_CONF_OPTS += --without-flatfile
endif
ifneq ($(BR2_PACKAGE_PHP_EXT_DBA_INI),y)
PHP_CONF_OPTS += --without-inifile
endif
ifeq ($(BR2_PACKAGE_PHP_EXT_DBA_DB4),y)
PHP_CONF_OPTS += --with-db4=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += berkeleydb
endif
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_SNMP),y)
PHP_CONF_OPTS += --with-snmp=$(STAGING_DIR)/usr
PHP_DEPENDENCIES += netsnmp
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_GD),y)
PHP_CONF_OPTS += \
	--enable-gd \
	--with-jpeg \
	--with-freetype
PHP_DEPENDENCIES += jpeg libpng freetype zlib
endif

ifeq ($(BR2_PACKAGE_PHP_EXT_FFI),y)
PHP_CONF_OPTS += --with-ffi
PHP_DEPENDENCIES += libffi
endif

ifeq ($(BR2_PACKAGE_PHP_SAPI_FPM),y)
define PHP_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(@D)/sapi/fpm/init.d.php-fpm \
		$(TARGET_DIR)/etc/init.d/S49php-fpm
endef

define PHP_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/sapi/fpm/php-fpm.service \
		$(TARGET_DIR)/usr/lib/systemd/system/php-fpm.service
endef

define PHP_INSTALL_FPM_CONF
	$(INSTALL) -D -m 0644 package/php/php-fpm.conf \
		$(TARGET_DIR)/etc/php-fpm.conf
	rm -f $(TARGET_DIR)/etc/php-fpm.d/www.conf.default
	# remove unused sample status page /usr/php/php/fpm/status.html
	rm -rf $(TARGET_DIR)/usr/php
endef

PHP_POST_INSTALL_TARGET_HOOKS += PHP_INSTALL_FPM_CONF
endif

define PHP_EXTENSIONS_FIXUP
	$(SED) "/prefix/ s:/usr:$(STAGING_DIR)/usr:" \
		$(STAGING_DIR)/usr/bin/phpize
	$(SED) "/extension_dir/ s:/usr:$(TARGET_DIR)/usr:" \
		$(STAGING_DIR)/usr/bin/php-config
endef

PHP_POST_INSTALL_TARGET_HOOKS += PHP_EXTENSIONS_FIXUP

define PHP_INSTALL_FIXUP
	rm -rf $(TARGET_DIR)/usr/lib/php/build
	rm -f $(TARGET_DIR)/usr/bin/phpize
	$(INSTALL) -D -m 0755 $(PHP_DIR)/php.ini-production \
		$(TARGET_DIR)/etc/php.ini
	$(SED) 's%;date.timezone =.*%date.timezone = $(PHP_LOCALTIME)%' \
		$(TARGET_DIR)/etc/php.ini
	$(if $(BR2_PACKAGE_PHP_EXT_OPCACHE),
		$(SED) '/;extension=php_xsl.dll/azend_extension=opcache.so' \
		$(TARGET_DIR)/etc/php.ini)
endef

PHP_POST_INSTALL_TARGET_HOOKS += PHP_INSTALL_FIXUP

PHP_CONF_ENV += CFLAGS="$(PHP_CFLAGS)" CXXFLAGS="$(PHP_CXXFLAGS)"

HOST_PHP_CONF_OPTS = \
	--disable-all \
	--without-pear \
	--with-config-file-path=$(HOST_DIR)/etc \
	--disable-phpdbg \
	--with-external-pcre \
	--enable-phar \
	--enable-json \
	--enable-filter \
	--enable-mbstring \
	--enable-tokenizer \
	--with-openssl=$(HOST_DIR)

HOST_PHP_DEPENDENCIES = \
	host-oniguruma \
	host-openssl \
	host-pcre2 \
	host-pkgconf

# PHP can't be AUTORECONFed the standard way unfortunately
HOST_PHP_DEPENDENCIES += host-autoconf host-automake host-libtool
define HOST_PHP_BUILDCONF
	cd $(@D) ; $(HOST_MAKE_ENV) ./buildconf --force
endef
HOST_PHP_PRE_CONFIGURE_HOOKS += HOST_PHP_BUILDCONF

$(eval $(autotools-package))
$(eval $(host-autotools-package))
