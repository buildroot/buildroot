################################################################################
#
# localedef
#
################################################################################

# Use the same VERSION, SITE, and LICENSE as target glibc
# As in glibc.mk, generate version string using:
#   git describe --match 'glibc-*' --abbrev=40 origin/release/MAJOR.MINOR/master | cut -d '-' -f 2-
LOCALEDEF_VERSION = 2.44-23-g11ac3d78fc5e4f7f2846002e099f773ad8ff82fc
LOCALEDEF_SOURCE = glibc-$(LOCALEDEF_VERSION)$(BR_FMT_VERSION_git).tar.gz
LOCALEDEF_SITE = https://gitlab.com/gnutools/glibc.git
LOCALEDEF_SITE_METHOD = git
HOST_LOCALEDEF_DL_SUBDIR = glibc

LOCALEDEF_LICENSE = \
	GPL-2.0+ (programs), \
	LGPL-2.1+, BSD-2-Clause, BSD-3-Clause, BSL-1.0, FSFAP, ISC, other permissive licenses, public domain (library), \
	LGPL-3.0+ (sysdeps/htl/raise.c, for Hurd only), \
	GPL-3.0+ (scripts/move-if-change), \
	GPL-3.0+ WITH Texinfo-exception (manual/texinfo.tex), \
	GFDL-1.3-or-later (manual)
LOCALEDEF_LICENSE_FILES = COPYINGv2 COPYING.LESSERv2 COPYINGv3 LICENSES manual/fdl-1.3.texi

HOST_LOCALEDEF_DEPENDENCIES = \
	$(BR2_MAKE_HOST_DEPENDENCY) \
	$(BR2_PYTHON3_HOST_DEPENDENCY) \
	host-bison \
	host-gawk

HOST_LOCALEDEF_CONF_ENV += ac_cv_prog_MAKE="$(BR2_MAKE)"

# Even though we use the autotools-package infrastructure, we have to override
# the default configure commands for since we have to build out-of-tree, but we
# can't use the same 'symbolic link to configure' used with the gcc packages.
define HOST_LOCALEDEF_CONFIGURE_CMDS
	mkdir -p $(@D)/build
	# Do the configuration
	(cd $(@D)/build; \
		$(HOST_LOCALEDEF_CONF_ENV) \
		$(HOST_CONFIGURE_OPTS) \
		$(SHELL) $(@D)/configure \
		libc_cv_forced_unwind=yes \
		libc_cv_ssp=no \
		--target=$(GNU_HOST_NAME) \
		--host=$(GNU_HOST_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
		--with-pkgversion="Buildroot" \
		--without-cvs \
		--disable-profile \
		--without-gd \
		--enable-obsolete-rpc)
endef

define HOST_LOCALEDEF_BUILD_CMDS
	$(HOST_MAKE_ENV) $(BR2_MAKE1) $(HOST_LOCALEDEF_MAKE_OPTS) \
		-C $(@D)/build locale/others
endef

# The makefile does not implement an install target for localedef
define HOST_LOCALEDEF_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/build/locale/localedef $(HOST_DIR)/bin/localedef
endef

$(eval $(host-autotools-package))
