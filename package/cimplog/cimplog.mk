################################################################################
#
# cimplog
#
################################################################################

CIMPLOG_VERSION = af8cbb5c98897116a3a10201aae4525a9b01448f
CIMPLOG_SITE_METHOD = git
CIMPLOG_SITE = git://github.com/Comcast/cimplog.git
CIMPLOG_INSTALL_STAGING = YES

$(eval $(cmake-package))
