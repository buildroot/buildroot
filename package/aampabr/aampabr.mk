################################################################################
#
# aampabr
#
################################################################################

AAMPABR_VERSION = 3ddb58dea9e5212b4796b0902e5fdccfdcb2a646
AAMPABR_SITE_METHOD = git
AAMPABR_SITE = https://code.rdkcentral.com/r/rdk/components/generic/aampabr
AAMPABR_INSTALL_STAGING = YES

$(eval $(cmake-package))
