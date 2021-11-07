################################################################################
#
# boinc
#
################################################################################

BOINC_VERSION_MAJOR = 7.18
BOINC_VERSION = $(BOINC_VERSION_MAJOR).1
BOINC_SITE = \
	$(call github,BOINC,boinc,client_release/$(BOINC_VERSION_MAJOR)/$(BOINC_VERSION))
BOINC_LICENSE = LGPL-3.0+
BOINC_LICENSE_FILES = COPYING COPYING.LESSER
BOINC_CPE_ID_VENDOR = rom_walton
BOINC_SELINUX_MODULES = boinc
BOINC_DEPENDENCIES = host-pkgconf libcurl openssl
BOINC_AUTORECONF = YES
# The ac_cv_c_undeclared_builtin_options value is to help
# AC_CHECK_DECLS realize that it doesn't need any particular compiler
# option to get an error when building a program that uses undeclared
# symbols. Otherwise, AC_CHECK_DECLS is confused by the configure
# script unconditionally passing -mavx, which only exists on x86, and
# therefore causes a failure on all other architectures.
BOINC_CONF_ENV = \
	ac_cv_c_undeclared_builtin_options='none needed' \
	ac_cv_path__libcurl_config=$(STAGING_DIR)/usr/bin/curl-config
BOINC_CONF_OPTS = \
	--disable-apps \
	--disable-boinczip \
	--disable-manager \
	--disable-server \
	--enable-client \
	--enable-dynamic-client-linkage \
	--enable-libraries \
	--with-pkg-config=$(PKG_CONFIG_HOST_BINARY) \
	--with-libcurl=$(STAGING_DIR)/usr

ifeq ($(BR2_PACKAGE_FREETYPE),y)
BOINC_DEPENDENCIES += freetype
endif

ifeq ($(BR2_PACKAGE_LIBFCGI),y)
BOINC_DEPENDENCIES += libfcgi
BOINC_CONF_OPTS += --enable-fcgi
else
BOINC_CONF_OPTS += --disable-fcgi
endif

BOINC_MAKE_OPTS = CXXFLAGS="$(TARGET_CXXFLAGS) -std=c++11"

# Remove boinc-client because it is incompatible with buildroot
define BOINC_REMOVE_UNNEEDED_FILE
	$(RM) $(TARGET_DIR)/etc/init.d/boinc-client
endef

BOINC_POST_INSTALL_TARGET_HOOKS += BOINC_REMOVE_UNNEEDED_FILE

define BOINC_USERS
	boinc -1 boinc -1 * /var/lib/boinc - BOINC user
endef

define BOINC_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/boinc/S99boinc-client \
		$(TARGET_DIR)/etc/init.d/S99boinc-client
endef

$(eval $(autotools-package))
