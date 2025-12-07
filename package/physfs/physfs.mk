################################################################################
#
# physfs
#
################################################################################

PHYSFS_VERSION = 3.2.0
PHYSFS_SITE = $(call github,icculus,physfs,release-$(PHYSFS_VERSION))

PHYSFS_LICENSE = Zlib
PHYSFS_LICENSE_FILES = LICENSE.txt

PHYSFS_INSTALL_STAGING = YES

PHYSFS_CONF_OPTS = -DPHYSFS_BUILD_TEST=OFF

ifeq ($(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
PHYSFS_CONF_OPTS += -DPHYSFS_BUILD_SHARED=ON
else
PHYSFS_CONF_OPTS += -DPHYSFS_BUILD_SHARED=OFF
endif

ifeq ($(BR2_STATIC_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
PHYSFS_CONF_OPTS += -DPHYSFS_BUILD_STATIC=ON
else
PHYSFS_CONF_OPTS += -DPHYSFS_BUILD_STATIC=OFF
endif

$(eval $(cmake-package))
