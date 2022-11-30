################################################################################
#
# qhull
#
################################################################################

QHULL_VERSION = 8.0.2
QHULL_SITE = http://www.qhull.org/download
QHULL_SOURCE = qhull-2020-src-$(QHULL_VERSION).tgz
QHULL_INSTALL_STAGING = YES
QHULL_LICENSE = BSD-Style
QHULL_LICENSE_FILES = COPYING.txt

# Force Release mode to always build qhull_r instead of qhull_rd
QHULL_CONF_OPTS = -DCMAKE_BUILD_TYPE=Release

# BUILD_SHARED_LIBS is handled in pkg-cmake.mk as it is a generic cmake variable
# although BUILD_STATIC_LIBS=ON is default, make it explicit,
# cmake and static/shared libs is confusing enough already.
ifeq ($(BR2_STATIC_LIBS),y)
QHULL_CONF_OPTS += -DBUILD_STATIC_LIBS=ON
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
QHULL_CONF_OPTS += -DBUILD_STATIC_LIBS=ON
else ifeq ($(BR2_SHARED_LIBS),y)
QHULL_CONF_OPTS += -DBUILD_STATIC_LIBS=OFF
endif

$(eval $(cmake-package))
