################################################################################
#
# php-pam
#
################################################################################

PHP_PAM_VERSION = 2.2.4
PHP_PAM_SITE = http://pecl.php.net/get
PHP_PAM_SOURCE = pam-$(PHP_PAM_VERSION).tgz
PHP_PAM_LICENSE = PHP-3.01
PHP_PAM_LICENSE_FILES = LICENSE
PHP_PAM_DEPENDENCIES = php linux-pam host-autoconf host-pkgconf

PHP_PAM_CONF_OPTS = \
	--with-php-config=$(STAGING_DIR)/usr/bin/php-config \
	--with-pam=$(STAGING_DIR)/usr

define PHP_PAM_PHPIZE
	(cd $(@D); \
		PHP_AUTOCONF=$(HOST_DIR)/bin/autoconf \
		PHP_AUTOHEADER=$(HOST_DIR)/bin/autoheader \
		$(STAGING_DIR)/usr/bin/phpize)
endef
PHP_PAM_PRE_CONFIGURE_HOOKS += PHP_PAM_PHPIZE

$(eval $(autotools-package))
