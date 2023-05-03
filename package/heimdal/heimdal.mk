################################################################################
#
# heimdal
#
################################################################################

HEIMDAL_VERSION = f4faaeaba371fff3f8d1bc14389f5e6d70ca8e17
HEIMDAL_SITE = $(call github,heimdal,heimdal,$(HEIMDAL_VERSION))
HOST_HEIMDAL_DEPENDENCIES = host-e2fsprogs host-ncurses host-pkgconf
HOST_HEIMDAL_AUTORECONF = YES
HEIMDAL_INSTALL_STAGING = YES
# static because of -fPIC issues with e2fsprogs on x86_64 host
HOST_HEIMDAL_CONF_OPTS = \
	--disable-shared \
	--enable-static \
	--without-openldap \
	--without-capng \
	--with-db-type-preference= \
	--without-sqlite3 \
	--without-libintl \
	--without-openssl \
	--without-berkeley-db \
	--without-readline \
	--without-libedit \
	--without-hesiod \
	--without-x \
	--disable-mdb-db \
	--disable-ndbm-db \
	--disable-heimdal-documentation

# Don't use compile_et from e2fsprogs as it raises a build failure with samba4
HOST_HEIMDAL_CONF_ENV = ac_cv_prog_COMPILE_ET=no MAKEINFO=true
HEIMDAL_LICENSE = BSD-3-Clause
HEIMDAL_LICENSE_FILES = LICENSE
HEIMDAL_CPE_ID_VENDOR = heimdal_project

# We need compile_et for samba4
define HOST_HEIMDAL_INSTALL_COMPILE_ET
	$(INSTALL) -m 0755 $(@D)/lib/com_err/compile_et \
		$(HOST_DIR)/bin/compile_et
endef

HOST_HEIMDAL_POST_INSTALL_HOOKS += \
	HOST_HEIMDAL_INSTALL_COMPILE_ET

$(eval $(host-autotools-package))
