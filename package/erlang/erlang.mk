################################################################################
#
# erlang
#
################################################################################

ERLANG_VERSION = 26.2.5.15
ERLANG_RELEASE = $(firstword $(subst ., ,$(ERLANG_VERSION)))
ERLANG_SITE = \
	https://github.com/erlang/otp/releases/download/OTP-$(ERLANG_VERSION)
ERLANG_SOURCE = otp_src_$(ERLANG_VERSION).tar.gz
ERLANG_DEPENDENCIES = host-erlang

ERLANG_LICENSE = Apache-2.0
ERLANG_LICENSE_FILES = LICENSE.txt
ERLANG_CPE_ID_VENDOR = erlang
ERLANG_CPE_ID_PRODUCT = erlang\/otp
ERLANG_INSTALL_STAGING = YES

define ERLANG_FIX_AUTOCONF_VERSION
	$(SED) "s/USE_AUTOCONF_VERSION=.*/USE_AUTOCONF_VERSION=$(AUTOCONF_VERSION)/" $(@D)/otp_build
endef

# Patched erts/aclocal.m4
define ERLANG_RUN_AUTOCONF
	cd $(@D) && PATH=$(BR_PATH) ./otp_build update_configure --no-commit
endef
ERLANG_DEPENDENCIES += host-autoconf
ERLANG_PRE_CONFIGURE_HOOKS += \
	ERLANG_FIX_AUTOCONF_VERSION \
	ERLANG_RUN_AUTOCONF
HOST_ERLANG_DEPENDENCIES += host-autoconf
HOST_ERLANG_PRE_CONFIGURE_HOOKS += \
	ERLANG_FIX_AUTOCONF_VERSION \
	ERLANG_RUN_AUTOCONF

# Return the EIV (Erlang Interface Version, EI_VSN)
# $(1): base directory, i.e. either $(HOST_DIR) or $(STAGING_DIR)/usr
erlang_ei_vsn = `sed -r -e '/^erl_interface-(.+)/!d; s//\1/' $(1)/lib/erlang/releases/$(ERLANG_RELEASE)/installed_application_versions`

# The configure checks for these functions fail incorrectly
ERLANG_CONF_ENV = ac_cv_func_isnan=yes ac_cv_func_isinf=yes

# Set erl_xcomp variables. See xcomp/erl-xcomp.conf.template
# for documentation.
ERLANG_CONF_ENV += erl_xcomp_sysroot=$(STAGING_DIR)

ERLANG_CONF_OPTS = --without-javac

# Force ERL_TOP to the downloaded source directory. This prevents
# Erlang's configure script from inadvertently using files from
# a version of Erlang installed on the host.
ERLANG_CONF_ENV += ERL_TOP=$(@D)
HOST_ERLANG_CONF_ENV += ERL_TOP=$(@D)

# erlang uses openssl for all things crypto. Since the host tools (such as
# rebar) uses crypto, we need to build host-erlang with support for openssl.
HOST_ERLANG_DEPENDENCIES += host-openssl
HOST_ERLANG_CONF_OPTS = --without-javac --with-ssl=$(HOST_DIR)

HOST_ERLANG_CONF_OPTS += --without-termcap

ifeq ($(BR2_PACKAGE_NCURSES),y)
ERLANG_CONF_OPTS += --with-termcap
ERLANG_DEPENDENCIES += ncurses
else
ERLANG_CONF_OPTS += --without-termcap
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
ERLANG_CONF_OPTS += --with-ssl
ERLANG_DEPENDENCIES += openssl
else
ERLANG_CONF_OPTS += --without-ssl
endif

ifeq ($(BR2_PACKAGE_UNIXODBC),y)
ERLANG_DEPENDENCIES += unixodbc
ERLANG_CONF_OPTS += --with-odbc
else
ERLANG_CONF_OPTS += --without-odbc
endif

# Always use Buildroot's zlib
ERLANG_CONF_OPTS += --disable-builtin-zlib
ERLANG_DEPENDENCIES += zlib

# Remove source, example, gs and wx files from staging and target.
ERLANG_REMOVE_PACKAGES = gs wx

ifneq ($(BR2_PACKAGE_ERLANG_MEGACO),y)
ERLANG_REMOVE_PACKAGES += megaco
endif

define ERLANG_REMOVE_STAGING_UNUSED
	for package in $(ERLANG_REMOVE_PACKAGES); do \
		rm -rf $(STAGING_DIR)/usr/lib/erlang/lib/$${package}-*; \
	done
endef

define ERLANG_REMOVE_TARGET_UNUSED
	find $(TARGET_DIR)/usr/lib/erlang -type d -name src -prune -exec rm -rf {} \;
	find $(TARGET_DIR)/usr/lib/erlang -type d -name examples -prune -exec rm -rf {} \;
	for package in $(ERLANG_REMOVE_PACKAGES); do \
		rm -rf $(TARGET_DIR)/usr/lib/erlang/lib/$${package}-*; \
	done
endef

ERLANG_POST_INSTALL_STAGING_HOOKS += ERLANG_REMOVE_STAGING_UNUSED
ERLANG_POST_INSTALL_TARGET_HOOKS += ERLANG_REMOVE_TARGET_UNUSED

$(eval $(autotools-package))
$(eval $(host-autotools-package))
