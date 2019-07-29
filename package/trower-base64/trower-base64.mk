################################################################################
#
# trower-base64
#
################################################################################

TROWER_BASE64_VERSION = 714345b1de398c8bc36d649c7ef10446e94e6cb4
TROWER_BASE64_SITE_METHOD = git
TROWER_BASE64_SITE = git://github.com/Comcast/trower-base64.git
TROWER_BASE64_INSTALL_STAGING = YES

$(eval $(cmake-package))
