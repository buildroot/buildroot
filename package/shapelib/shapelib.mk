################################################################################
#
# shapelib
#
################################################################################

SHAPELIB_VERSION = 1.6.1
SHAPELIB_SITE = http://download.osgeo.org/shapelib
SHAPELIB_LICENSE = MIT or LGPL-2.0
SHAPELIB_LICENSE_FILES = LICENSE-LGPL LICENSE-MIT web/license.html
SHAPELIB_CPE_ID_VENDOR = osgeo
SHAPELIB_INSTALL_STAGING = YES

$(eval $(autotools-package))
