################################################################################
#
# heimdal
#
################################################################################

HEIMDAL_VERSION = 8c3c97bdf6c06200418f1a85aa22beaa441c6b23
HEIMDAL_SITE = $(call github,heimdal,heimdal,$(HEIMDAL_VERSION))
HOST_HEIMDAL_DEPENDENCIES = host-ncurses host-pkgconf host-libxcrypt host-flex host-bison
HOST_HEIMDAL_AUTORECONF = YES

HOST_HEIMDAL_CONF_OPTS = \
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
HOST_HEIMDAL_CONF_ENV = ac_cv_prog_COMPILE_ET=no MAKEINFO=true LIBS=-lcrypt
HEIMDAL_LICENSE = BSD-3-Clause
HEIMDAL_LICENSE_FILES = LICENSE
HEIMDAL_CPE_ID_VALID = YES

# We need compile_et for samba4 and slc for target version of heimdal
# By default compile_et is not installed so we install it to bin
# By default slc is installed in libexec directory so we just link it
define HOST_HEIMDAL_INSTALL_BINARIES
	$(INSTALL) -m 0755 $(@D)/lib/com_err/compile_et $(HOST_DIR)/bin/compile_et
	ln -sf $(HOST_DIR)/libexec/heimdal/slc $(HOST_DIR)/bin/slc
endef

HOST_HEIMDAL_POST_INSTALL_HOOKS += HOST_HEIMDAL_INSTALL_BINARIES

$(eval $(host-autotools-package))
