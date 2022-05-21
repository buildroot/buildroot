################################################################################
#
# cjwt
#
################################################################################

CJWT_VERSION= 51714cf769c046ca454ebdf0ae2bc542a3d8b376
CJWT_SITE_METHOD = git
CJWT_SITE = https://github.com/Comcast/cjwt.git
CJWT_INSTALL_STAGING = YES

CJWT_DEPENDENCIES = trower-base64 openssl

CJWT_CONF_OPTS += \
    -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(CJWT_INCLUDE_DIRS)" \
    -DBUILD_TESTING=OFF \
    -DBUILD_BR=ON


CJWT_INCLUDE_DIRS = \
    -I$(STAGING_DIR)/usr/include \
    -I$(STAGING_DIR)/usr/include/cjson \
    -I$(STAGING_DIR)/usr/include/trower-base64

$(eval $(cmake-package))
