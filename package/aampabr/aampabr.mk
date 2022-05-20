################################################################################
#
# aampabr
#
################################################################################

AAMPABR_VERSION = 94628fea94ea26527c53a03c6245623017c6cfe9
AAMPABR_SITE_METHOD = git
AAMPABR_SITE = https://github.com/rdkcmf/rdk-aampabr
AAMPABR_INSTALL_STAGING = YES

$(eval $(cmake-package))
