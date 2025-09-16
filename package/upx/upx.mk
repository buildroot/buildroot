################################################################################
#
# upx
#
################################################################################

UPX_VERSION = 4.2.1
UPX_SITE = https://github.com/upx/upx/releases/download/v$(UPX_VERSION)
UPX_SOURCE = upx-$(UPX_VERSION)-src.tar.xz
UPX_LICENSE = GPL-2.0+
UPX_LICENSE_FILES = COPYING
UPX_CPE_ID_VENDOR = upx
UPX_SUPPORTS_IN_SOURCE_BUILD = NO

$(eval $(host-cmake-package))
