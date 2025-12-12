################################################################################
#
# unionfs
#
################################################################################

UNIONFS_VERSION = 3.7
UNIONFS_SITE = $(call github,rpodgorny,unionfs-fuse,v$(UNIONFS_VERSION))
UNIONFS_DEPENDENCIES = host-pkgconf
UNIONFS_LICENSE = BSD-3-Clause
UNIONFS_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_LIBFUSE3),y)
UNIONFS_CONF_OPTS += -DWITH_LIBFUSE3=TRUE
UNIONFS_DEPENDENCIES += libfuse3
else
UNIONFS_CONF_OPTS += -DWITH_LIBFUSE3=FALSE
UNIONFS_DEPENDENCIES += libfuse
endif

$(eval $(cmake-package))
