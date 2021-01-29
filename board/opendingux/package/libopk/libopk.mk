#############################################################
#
# libopk
#
#############################################################
LIBOPK_VERSION = 0b40691
LIBOPK_SITE = $(call github,pcercuei,libopk,$(LIBOPK_VERSION))
LIBOPK_DEPENDENCIES = libini zlib
LIBOPK_INSTALL_STAGING = YES

HOST_LIBOPK_DEPENDENCIES = host-libini host-zlib
HOST_LIBOPK_CONF_OPTS = -DBUILD_SHARED_LIBS=OFF

$(eval $(cmake-package))
$(eval $(host-cmake-package))
