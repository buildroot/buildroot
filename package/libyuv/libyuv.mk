################################################################################
#
# libyuv
#
################################################################################

LIBYUV_VERSION = 4825d9b29eea4dac24607245db7ec7d4c41c1964
LIBYUV_SITE = https://chromium.googlesource.com/libyuv/libyuv
LIBYUV_SITE_METHOD = git
LIBYUV_LICENSE = BSD-3-Clause
LIBYUV_LICENSE_FILES = LICENSE
LIBYUV_INSTALL_STAGING = YES
LIBYUV_DEPENDENCIES = $(if $(BR2_PACKAGE_JPEG),jpeg)

$(eval $(cmake-package))
