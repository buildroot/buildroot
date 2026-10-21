################################################################################
#
# libplacebo
#
################################################################################

LIBPLACEBO_VERSION = v7.360.1
LIBPLACEBO_SITE = https://code.videolan.org/videolan/libplacebo.git
LIBPLACEBO_SITE_METHOD = git
LIBPLACEBO_GIT_SUBMODULES = YES
LIBPLACEBO_LICENSE = LGPL-2.1+
LIBPLACEBO_LICENSE_FILES = LICENSE
LIBPLACEBO_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_LCMS2),y)
LIBPLACEBO_DEPENDENCIES += lcms2
LIBPLACEBO_CONF_OPTS += -Dlcms=disabled
else
LIBPLACEBO_CONF_OPTS += -Dlcms=disabled
endif

ifeq ($(BR2_PACKAGE_XXHASH),y)
LIBPLACEBO_DEPENDENCIES += xxhash
LIBPLACEBO_CONF_OPTS += -Dxxhash=disabled
else
LIBPLACEBO_CONF_OPTS += -Dxxhash=disabled
endif

$(eval $(meson-package))
