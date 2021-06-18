################################################################################
#
# aampabr
#
################################################################################

AAMPABR_VERSION = baf59ee4fa697809ed9a11552c02e36a02e28fd7
AAMPABR_SITE_METHOD = git
AAMPABR_SITE = https://code.rdkcentral.com/r/rdk/components/generic/aampabr
AAMPABR_INSTALL_STAGING = YES

$(eval $(cmake-package))
