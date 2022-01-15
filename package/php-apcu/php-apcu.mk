################################################################################
#
# php-apcu
#
################################################################################

PHP_APCU_VERSION = 5.1.20
PHP_APCU_SITE = http://pecl.php.net/get
PHP_APCU_SOURCE = apcu-$(PHP_APCU_VERSION).tgz
PHP_APCU_LICENSE = PHP-3.01
PHP_APCU_LICENSE_FILES = LICENSE
PHP_APCU_DEPENDENCIES = php host-autoconf

PHP_APCU_CONF_OPTS = \
	--with-php-config=$(STAGING_DIR)/usr/bin/php-config

define PHP_APCU_PHPIZE
	(cd $(@D); \
		PHP_AUTOCONF=$(HOST_DIR)/usr/bin/autoconf \
		PHP_AUTOHEADER=$(HOST_DIR)/usr/bin/autoheader \
		$(STAGING_DIR)/usr/bin/phpize)
endef
PHP_APCU_PRE_CONFIGURE_HOOKS += PHP_APCU_PHPIZE

ifeq ($(BR2_TOOLCHAIN_HAS_SYNC_4),)
PHP_APCU_CONF_OPTS += --disable-apcu-rwlocks
endif

$(eval $(autotools-package))
