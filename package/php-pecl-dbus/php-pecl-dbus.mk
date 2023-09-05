################################################################################
#
# php-pecl-dbus
#
################################################################################

PHP_PECL_DBUS_VERSION = b147624d480c3353e6c700e9a2d0c6f14d853941
PHP_PECL_DBUS_SITE = $(call github,derickr,pecl-dbus,$(PHP_PECL_DBUS_VERSION))
PHP_PECL_DBUS_LICENSE = PHP-3.01
PHP_PECL_DBUS_LICENSE_FILES = LICENSE
PHP_PECL_DBUS_DEPENDENCIES = php dbus libxml2 host-autoconf host-pkgconf

PHP_PECL_DBUS_CONF_OPTS = \
	--with-php-config=$(STAGING_DIR)/usr/bin/php-config

define PHP_PECL_DBUS_PHPIZE
	(cd $(@D); \
		PHP_AUTOCONF=$(HOST_DIR)/bin/autoconf \
		PHP_AUTOHEADER=$(HOST_DIR)/bin/autoheader \
		$(STAGING_DIR)/usr/bin/phpize)
endef
PHP_PECL_DBUS_PRE_CONFIGURE_HOOKS += PHP_PECL_DBUS_PHPIZE

$(eval $(autotools-package))
