################################################################################
#
# php-lua
#
################################################################################

PHP_LUA_VERSION = 2.0.7
PHP_LUA_SITE = http://pecl.php.net/get
PHP_LUA_SOURCE = lua-$(PHP_LUA_VERSION).tgz
PHP_LUA_LICENSE = PHP-3.01
PHP_LUA_LICENSE_FILES = LICENSE
PHP_LUA_DEPENDENCIES = php luainterpreter host-autoconf host-pkgconf

PHP_LUA_CONF_OPTS = \
	--with-php-config=$(STAGING_DIR)/usr/bin/php-config \
	--with-lua=$(STAGING_DIR)/usr

# The php-lua package uses the following code to search for the lua library
#      if test "$PHP_LUA_VERSION" != "yes" -a "$PHP_LUA_VERSION" != "no"; then
#        LUA_LIB_SUFFIX=lua$PHP_LUA_VERSION
#      else
#        LUA_LIB_SUFFIX=lua
#      fi
#      LUA_LIB_NAME=lib$LUA_LIB_SUFFIX
# luajit library name is libluajit-x.y with x.y the api version.
# In order to use luajit, we use jit-x.y as "lua-version".
ifeq ($(BR2_PACKAGE_LUAJIT),y)
PHP_LUA_CONF_OPTS += --with-lua-version=jit-$(LUAINTERPRETER_ABIVER)
endif

define PHP_LUA_PHPIZE
	(cd $(@D); \
		PHP_AUTOCONF=$(HOST_DIR)/usr/bin/autoconf \
		PHP_AUTOHEADER=$(HOST_DIR)/usr/bin/autoheader \
		$(STAGING_DIR)/usr/bin/phpize)
endef
PHP_LUA_PRE_CONFIGURE_HOOKS += PHP_LUA_PHPIZE

$(eval $(autotools-package))
