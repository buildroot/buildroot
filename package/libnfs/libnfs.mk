################################################################################
#
# libnfs
#
################################################################################

LIBNFS_VERSION = 5.0.3
LIBNFS_SITE = $(call github,sahlberg,libnfs,libnfs-$(LIBNFS_VERSION))
LIBNFS_INSTALL_STAGING = YES
LIBNFS_AUTORECONF = YES
LIBNFS_LICENSE = LGPL-2.1+ (library), BSD-2-Clause (protocol, .x files), GPL-3.0+ (examples)
LIBNFS_LICENSE_FILES = COPYING LICENCE-BSD.txt LICENCE-LGPL-2.1.txt LICENCE-GPL-3.txt
LIBNFS_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_LIBTIRPC),y)
LIBNFS_DEPENDENCIES += libtirpc
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
LIBNFS_CONF_OPTS += --enable-pthread
else
LIBNFS_CONF_OPTS += --disable-pthread
endif

$(eval $(autotools-package))
