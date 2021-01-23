#############################################################
#
# libopk
#
#############################################################
LIBOPK_VERSION = 3c918c8
LIBOPK_SITE = $(call github,pcercuei,libopk,$(LIBOPK_VERSION))
LIBOPK_DEPENDENCIES = libini zlib
LIBOPK_INSTALL_STAGING = YES

HOST_LIBOPK_DEPENDENCIES = host-libini host-zlib

$(eval $(cmake-package))
$(eval $(host-cmake-package))
