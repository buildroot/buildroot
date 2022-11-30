################################################################################
#
# libsysfs
#
################################################################################

LIBSYSFS_VERSION = 2.1.1
LIBSYSFS_SITE = $(call github,linux-ras,sysfsutils,v$(LIBSYSFS_VERSION))
LIBSYSFS_INSTALL_STAGING = YES
LIBSYSFS_LICENSE = GPL-2.0 (utilities), LGPL-2.1+ (library)
LIBSYSFS_LICENSE_FILES = cmd/GPL lib/LGPL
LIBSYSFS_CPE_ID_VENDOR = sysfsutils_project
LIBSYSFS_CPE_ID_PRODUCT = sysfsutils
# From git
LIBSYSFS_AUTORECONF = YES

$(eval $(autotools-package))
