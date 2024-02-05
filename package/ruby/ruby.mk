################################################################################
#
# ruby
#
################################################################################

RUBY_VERSION_MAJOR = 3.3
RUBY_VERSION = $(RUBY_VERSION_MAJOR).0
RUBY_VERSION_EXT = 3.3.0
RUBY_SITE = http://cache.ruby-lang.org/pub/ruby/$(RUBY_VERSION_MAJOR)
RUBY_SOURCE = ruby-$(RUBY_VERSION).tar.xz

RUBY_LICENSE = \
	Ruby or BSD-2-Clause, \
	BSD-3-Clause, \
	MIT, \
	others
RUBY_LICENSE_FILES = LEGAL COPYING BSDL

RUBY_CPE_ID_VENDOR = ruby-lang

RUBY_DEPENDENCIES = host-pkgconf host-ruby
HOST_RUBY_DEPENDENCIES = host-pkgconf host-openssl
RUBY_MAKE_ENV = $(TARGET_MAKE_ENV)
RUBY_CONF_OPTS = \
	--disable-install-doc \
	--disable-rpath \
	--disable-rubygems \
	--disable-yjit
HOST_RUBY_CONF_OPTS = \
	--disable-install-doc \
	--disable-yjit \
	--with-out-ext=curses,readline \
	--without-gmp

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
RUBY_CONF_ENV += LIBS=-latomic
endif

ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
# On uClibc, finite, isinf and isnan are not directly implemented as
# functions.  Instead math.h #define's these to __finite, __isinf and
# __isnan, confusing the Ruby configure script. Tell it that they
# really are available.
RUBY_CONF_ENV += \
	ac_cv_func_finite=yes \
	ac_cv_func_isinf=yes \
	ac_cv_func_isnan=yes
endif

ifeq ($(BR2_TOOLCHAIN_HAS_SSP),)
RUBY_CONF_ENV += stack_protector=no
endif

# Force optionals to build before we do
ifeq ($(BR2_PACKAGE_BERKELEYDB),y)
RUBY_DEPENDENCIES += berkeleydb
endif
ifeq ($(BR2_PACKAGE_LIBFFI),y)
RUBY_DEPENDENCIES += libffi
else
# Disable fiddle to avoid a build failure with bundled-libffi on MIPS
RUBY_CONF_OPTS += --with-out-ext=fiddle
endif
ifeq ($(BR2_PACKAGE_GDBM),y)
RUBY_DEPENDENCIES += gdbm
endif
ifeq ($(BR2_PACKAGE_LIBYAML),y)
RUBY_DEPENDENCIES += libyaml
endif
ifeq ($(BR2_PACKAGE_NCURSES),y)
RUBY_DEPENDENCIES += ncurses
endif
ifeq ($(BR2_PACKAGE_OPENSSL),y)
RUBY_DEPENDENCIES += openssl
endif
ifeq ($(BR2_PACKAGE_READLINE),y)
RUBY_DEPENDENCIES += readline
endif
ifeq ($(BR2_PACKAGE_ZLIB),y)
RUBY_DEPENDENCIES += zlib
endif
ifeq ($(BR2_PACKAGE_GMP),y)
RUBY_DEPENDENCIES += gmp
RUBY_CONF_OPTS += --with-gmp
else
RUBY_CONF_OPTS += --without-gmp
endif

RUBY_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_83143),y)
RUBY_CFLAGS += -freorder-blocks-algorithm=simple
endif

RUBY_CONF_OPTS += CFLAGS="$(RUBY_CFLAGS)"

# Remove rubygems and friends, as they need extensions that aren't
# built and a target compiler.
RUBY_EXTENSIONS_REMOVE = rake* rdoc* rubygems*
define RUBY_REMOVE_RUBYGEMS
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/, gem rdoc ri rake)
	rm -rf $(TARGET_DIR)/usr/lib/ruby/gems
	rm -rf $(addprefix $(TARGET_DIR)/usr/lib/ruby/$(RUBY_VERSION_EXT)/, \
		$(RUBY_EXTENSIONS_REMOVE))
endef
RUBY_POST_INSTALL_TARGET_HOOKS += RUBY_REMOVE_RUBYGEMS

$(eval $(autotools-package))
$(eval $(host-autotools-package))
