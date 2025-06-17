################################################################################
#
# rapidjson
#
################################################################################

RAPIDJSON_VERSION = 24b5e7a8b27f42fa16b96fc70aade9106cf7102f
RAPIDJSON_SITE = $(call github,Tencent,rapidjson,$(RAPIDJSON_VERSION))
RAPIDJSON_LICENSE = MIT
RAPIDJSON_LICENSE_FILES = license.txt
RAPIDJSON_CPE_ID_VENDOR = tencent

# rapidjson is a header-only C++ library
RAPIDJSON_INSTALL_TARGET = NO
RAPIDJSON_INSTALL_STAGING = YES

RAPIDJSON_CONF_OPTS = \
	-DRAPIDJSON_BUILD_DOC=OFF \
	-DRAPIDJSON_BUILD_EXAMPLES=OFF \
	-DRAPIDJSON_BUILD_TESTS=OFF

$(eval $(cmake-package))
