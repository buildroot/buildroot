################################################################################
#
# libcgroup
#
################################################################################

LIBCGROUP_VERSION = 2.0.3
LIBCGROUP_SITE = https://github.com/libcgroup/libcgroup/releases/download/v$(LIBCGROUP_VERSION)
LIBCGROUP_LICENSE = LGPL-2.1
LIBCGROUP_LICENSE_FILES = COPYING
LIBCGROUP_CPE_ID_VALID = YES
LIBCGROUP_DEPENDENCIES = host-bison host-flex
LIBCGROUP_INSTALL_STAGING = YES

LIBCGROUP_CONF_OPTS = \
	--disable-daemon \
	--disable-initscript-install

ifeq ($(BR2_PACKAGE_LIBCGROUP_TOOLS),y)
LIBCGROUP_CONF_OPTS += --enable-tools
else
LIBCGROUP_CONF_OPTS += --disable-tools
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
LIBCGROUP_DEPENDENCIES += linux-pam
LIBCGROUP_CONF_OPTS += --enable-pam
else
LIBCGROUP_CONF_OPTS += --disable-pam
endif

ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),)
LIBCGROUP_DEPENDENCIES += musl-fts
endif

$(eval $(autotools-package))
