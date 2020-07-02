################################################################################
#
# cjwt
#
################################################################################

CJWT_VERSION = 1b023c41bb2d6dbbf493c202ed81f06c84d5b51b
CJWT_SITE_METHOD = git
CJWT_SITE = git://github.com/Comcast/cjwt.git
CJWT_INSTALL_STAGING = YES

CJWT_DEPENDENCIES = trower-base64 openssl

CJWT_CONF_OPTS += \
    -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(CJWT_INCLUDE_DIRS)" \
    -DBUILD_BR=ON


CJWT_INCLUDE_DIRS = \
    -I$(STAGING_DIR)/usr/include \
    -I$(STAGING_DIR)/usr/include/cjson \
    -I$(STAGING_DIR)/usr/include/trower-base64

$(eval $(cmake-package))
