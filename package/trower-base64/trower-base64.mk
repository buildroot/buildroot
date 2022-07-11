################################################################################
#
# trower-base64
#
################################################################################

TROWER_BASE64_VERSION = fbb9440ae2bc1118866baefcea7ff814f16613dd
TROWER_BASE64_SITE_METHOD = git
TROWER_BASE64_SITE = https://github.com/Comcast/trower-base64.git
TROWER_BASE64_INSTALL_STAGING = YES

TROWER_BASE64_CONF_OPTS = -DBUILD_TESTING=OFF
$(eval $(cmake-package))
