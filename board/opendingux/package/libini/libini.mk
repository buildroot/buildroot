#############################################################
#
# libini
#
#############################################################
LIBINI_VERSION = add8d48
LIBINI_SITE = $(call github,pcercuei,libini,$(LIBINI_VERSION))
LIBINI_INSTALL_STAGING = YES

HOST_LIBINI_CONF_OPTS = -DBUILD_SHARED_LIBS=OFF

$(eval $(cmake-package))
$(eval $(host-cmake-package))
