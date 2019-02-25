#############################################################
#
# libini
#
#############################################################
LIBINI_VERSION = c3413da
LIBINI_SITE = $(call github,pcercuei,libini,$(LIBINI_VERSION))
LIBINI_INSTALL_STAGING = YES

$(eval $(cmake-package))
