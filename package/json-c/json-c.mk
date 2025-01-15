################################################################################
#
# json-c
#
################################################################################

JSON_C_VERSION = 0.18
JSON_C_SITE = https://s3.amazonaws.com/json-c_releases/releases
JSON_C_INSTALL_STAGING = YES
JSON_C_LICENSE = MIT
JSON_C_LICENSE_FILES = COPYING
JSON_C_CPE_ID_VENDOR = json-c
JSON_C_CONF_OPTS = -DBUILD_APPS=OFF -DDISABLE_EXTRA_LIBS=ON

$(eval $(cmake-package))
$(eval $(host-cmake-package))
