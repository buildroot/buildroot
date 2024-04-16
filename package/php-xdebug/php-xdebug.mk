################################################################################
#
# php-xdebug
#
################################################################################

PHP_XDEBUG_VERSION = 3.3.1
PHP_XDEBUG_SOURCE = xdebug-$(PHP_XDEBUG_VERSION).tgz
PHP_XDEBUG_SITE = https://xdebug.org/files
PHP_XDEBUG_INSTALL_STAGING = YES
PHP_XDEBUG_LICENSE = Xdebug License (PHP-3.01-like)
PHP_XDEBUG_LICENSE_FILES = LICENSE
# phpize does the autoconf magic
PHP_XDEBUG_DEPENDENCIES = php host-autoconf
PHP_XDEBUG_CONF_OPTS = \
	--enable-xdebug \
	--with-php-config=$(STAGING_DIR)/usr/bin/php-config

define PHP_XDEBUG_PHPIZE
	(cd $(@D); \
		PHP_AUTOCONF=$(HOST_DIR)/bin/autoconf \
		PHP_AUTOHEADER=$(HOST_DIR)/bin/autoheader \
		$(STAGING_DIR)/usr/bin/phpize)
endef

PHP_XDEBUG_PRE_CONFIGURE_HOOKS += PHP_XDEBUG_PHPIZE

ifeq ($(BR2_PACKAGE_ZLIB),y)
PHP_XDEBUG_CONF_OPTS += --with-xdebug-compression
PHP_XDEBUG_DEPENDENCIES += zlib
else
PHP_XDEBUG_CONF_OPTS += --without-xdebug-compression
endif

$(eval $(autotools-package))
