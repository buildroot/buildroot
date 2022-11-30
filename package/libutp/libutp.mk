################################################################################
#
# libutp
#
################################################################################

LIBUTP_VERSION = 059c9449a104e440e4f913756a5f560dd4ae76a9
LIBUTP_SITE = $(call github,transmission,libutp,$(LIBUTP_VERSION))
LIBUTP_LICENSE = MIT
LIBUTP_LICENSE_FILES = LICENSE
LIBUTP_INSTALL_STAGING = YES

$(eval $(cmake-package))
