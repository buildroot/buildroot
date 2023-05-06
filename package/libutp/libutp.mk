################################################################################
#
# libutp
#
################################################################################

LIBUTP_VERSION = c95738b1a6644b919e5b64d3ea9736cfc5894e0b
LIBUTP_SITE = $(call github,transmission,libutp,$(LIBUTP_VERSION))
LIBUTP_LICENSE = MIT
LIBUTP_LICENSE_FILES = LICENSE
LIBUTP_INSTALL_STAGING = YES
LIBUTP_CONF_OPTS = -DLIBUTP_ENABLE_WERROR=OFF

$(eval $(cmake-package))
