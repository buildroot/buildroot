################################################################################
#
# aampmetrics
#
################################################################################

AAMPMETRICS_VERSION = c6b9de63f2a8755db59ee300c02c6c89e392dad5
AAMPMETRICS_SITE_METHOD = git
AAMPMETRICS_SITE = https://github.com/rdkcmf/rdk-aampmetrics
AAMPMETRICS_INSTALL_STAGING = YES
AAMPMETRICS_DEPENDENCIES = cjson

$(eval $(cmake-package))
