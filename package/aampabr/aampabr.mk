################################################################################
#
# aampabr
#
################################################################################

AAMPABR_VERSION = e26f47a03c2648e049c7605cf4a471cda3d37464
AAMPABR_SITE_METHOD = git
AAMPABR_SITE = https://code.rdkcentral.com/r/rdk/components/generic/aampabr
AAMPABR_INSTALL_STAGING = YES

$(eval $(cmake-package))
