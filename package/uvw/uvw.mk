################################################################################
#
# uvw
#
################################################################################

UVW_VERSION = 3.4.0_libuv_v1.48
UVW_SITE = $(call github,skypjack,uvw,v$(UVW_VERSION))
UVW_INSTALL_STAGING = YES
UVW_INSTALL_TARGET = NO
UVW_SUPPORTS_IN_SOURCE_BUILD = NO
UVW_DEPENDENCIES = libuv
UVW_LICENSE = MIT
UVW_LICENSE_FILES = LICENSE

$(eval $(cmake-package))
