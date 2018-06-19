################################################################################
#
# nghttp2
#
################################################################################

NGHTTP2_VERSION = 939ad5ddbeeb153c6df23ddfb33b0e9b299708a5
NGHTTP2_SITE = git@github.com:nghttp2/nghttp2.git
NGHTTP2_SITE_METHOD = git
NGHTTP2_LICENSE = PROPRIETARY
NGHTTP2_INSTALL_STAGING = YES

$(eval $(cmake-package))

