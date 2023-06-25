################################################################################
#
# libcgroup
#
################################################################################

LIBCGROUP_VERSION = 2.0.3
LIBCGROUP_SITE = https://github.com/libcgroup/libcgroup/releases/download/v$(LIBCGROUP_VERSION)
LIBCGROUP_LICENSE = LGPL-2.1
LIBCGROUP_LICENSE_FILES = COPYING
LIBCGROUP_CPE_ID_VENDOR = libcgroup_project
LIBCGROUP_DEPENDENCIES = host-bison host-flex
LIBCGROUP_INSTALL_STAGING = YES

# Undefining _FILE_OFFSET_BITS here because of a "bug" with glibc fts.h
# large file support. See https://bugzilla.redhat.com/show_bug.cgi?id=574992
# for more information.
LIBCGROUP_CONF_ENV = \
	CXXFLAGS="$(TARGET_CXXFLAGS) -U_FILE_OFFSET_BITS" \
	CFLAGS="$(TARGET_CFLAGS) -U_FILE_OFFSET_BITS"

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
