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

$(eval $(host-autotools-package))
