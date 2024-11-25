################################################################################
#
# tar
#
################################################################################

TAR_VERSION = 1.35
TAR_SOURCE = tar-$(TAR_VERSION).tar.xz
TAR_SITE = $(BR2_GNU_MIRROR)/tar
TAR_LICENSE = GPL-3.0+
TAR_LICENSE_FILES = COPYING
TAR_CPE_ID_VENDOR = gnu
TAR_DEPENDENCIES = $(TARGET_NLS_DEPENDENCIES)
TAR_CONF_ENV = LIBS=$(TARGET_NLS_LIBS)
# 0002-Fix-savannah-bug-#64441.patch
# 0003-tests-fix-LDADD.patch
TAR_AUTORECONF = YES

# The package is a dependency to ccache so ccache cannot be a dependency
HOST_TAR_ADD_CCACHE_DEPENDENCY = NO

# busybox installs in /bin, so we need tar to install as well in /bin
# so that we don't end up with two different tar
#
# --disable-year2038: tells the configure script to not abort if the
# system is not Y2038 compliant. tar will support year2038 if the
# system is compliant even with this option passed
TAR_CONF_OPTS = \
	--exec-prefix=/ \
	--disable-year2038

ifeq ($(BR2_PACKAGE_ACL),y)
TAR_DEPENDENCIES += acl
TAR_CONF_OPTS += --with-posix-acls
else
TAR_CONF_OPTS += --without-posix-acls
endif

ifeq ($(BR2_PACKAGE_ATTR),y)
TAR_DEPENDENCIES += attr
TAR_CONF_OPTS += --with-xattrs
else
TAR_CONF_OPTS += --without-xattrs
endif

$(eval $(autotools-package))

# host-tar: use cpio.gz instead of tar.gz to prevent chicken-egg problem
# of needing tar to build tar.
HOST_TAR_SOURCE = tar-$(TAR_VERSION).cpio.gz

define HOST_TAR_EXTRACT_CMDS
	mkdir -p $(@D)
	cd $(@D) && \
		$(call suitable-extractor,$(HOST_TAR_SOURCE)) $(TAR_DL_DIR)/$(HOST_TAR_SOURCE) | cpio -i --preserve-modification-time
	mv $(@D)/tar-$(HOST_TAR_VERSION)/* $(@D)
	rmdir $(@D)/tar-$(HOST_TAR_VERSION)
endef

HOST_TAR_CONF_OPTS = --without-selinux

# we are built before ccache
HOST_TAR_CONF_ENV = \
	CC="$(HOSTCC_NOCCACHE)" \
	CXX="$(HOSTCXX_NOCCACHE)"

# Patches 0002-Fix-savannah-bug-#64441.patch and
# 0003-tests-fix-LDADD.patch are patching Makefile.am, so they do
# require TAR_AUTORECONF = YES above. However, for the host-tar
# package we can't do this: we can't have host-tar depend on
# host-{autoconf,automake,libtool} as those in turn might depend on
# host-tar. Since the patches 0002 and 0003 are only related to
# linking against libiconv, which is only an issue for the target tar,
# we do not autoreconf, and touch the corresponding Makefile.in to
# prevent them from being re-generated.
HOST_TAR_AUTORECONF = NO
define HOST_TAR_NO_AUTORECONF
	touch $(@D)/src/Makefile.in $(@D)/tests/Makefile.in
endef
HOST_TAR_POST_PATCH_HOOKS += HOST_TAR_NO_AUTORECONF

$(eval $(host-autotools-package))
