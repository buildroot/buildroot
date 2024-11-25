################################################################################
#
# opencv4-contrib
#
################################################################################

OPENCV4_CONTRIB_VERSION = 4.10.0
OPENCV4_CONTRIB_SITE = $(call github,opencv,opencv_contrib,$(OPENCV4_CONTRIB_VERSION))
OPENCV4_CONTRIB_INSTALL_TARGET = NO
OPENCV4_CONTRIB_LICENSE = Apache-2.0
OPENCV4_CONTRIB_LICENSE_FILES = LICENSE

# Modules provided by opencv4-contrib are built as part of the opencv4 package,
# so opencv4-contrib only serves for downloading the source code.

$(eval $(generic-package))
