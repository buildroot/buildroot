################################################################################
#
# libutp
#
################################################################################

LIBUTP_VERSION = fda9f4b3db97ccb243fcbed2ce280eb4135d705b
LIBUTP_SITE = $(call github,transmission,libutp,$(LIBUTP_VERSION))
LIBUTP_LICENSE = MIT
LIBUTP_LICENSE_FILES = LICENSE
LIBUTP_INSTALL_STAGING = YES

$(eval $(cmake-package))
