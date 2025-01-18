################################################################################
#
# taglib
#
################################################################################

TAGLIB_VERSION = 2.0.2
TAGLIB_SITE = https://taglib.org/releases
TAGLIB_INSTALL_STAGING = YES
TAGLIB_DEPENDENCIES = utfcpp
TAGLIB_LICENSE = LGPL-2.1 or MPL-1.1
TAGLIB_LICENSE_FILES = COPYING.LGPL COPYING.MPL
TAGLIB_CPE_ID_VENDOR = taglib

ifeq ($(BR2_PACKAGE_ZLIB),y)
TAGLIB_DEPENDENCIES += zlib
TAGLIB_CONF_OPTS += -DWITH_ZLIB=ON
else
TAGLIB_CONF_OPTS += -DWITH_ZLIB=OFF
endif

define TAGLIB_REMOVE_DEVFILE
	rm -f $(TARGET_DIR)/usr/bin/taglib-config
endef

TAGLIB_POST_INSTALL_TARGET_HOOKS += TAGLIB_REMOVE_DEVFILE

$(eval $(cmake-package))
