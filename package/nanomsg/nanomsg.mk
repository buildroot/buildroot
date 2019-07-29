################################################################################
#
# nanomsg
#
################################################################################

NANOMSG_VERSION = 0c1aa2b288f6b167dbafe7e29c20e6fc7e71c000
NANOMSG_SITE_METHOD = git
NANOMSG_SITE = git://github.com/nanomsg/nanomsg.git
NANOMSG_INSTALL_STAGING = YES

$(eval $(cmake-package))
