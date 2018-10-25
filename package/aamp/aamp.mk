################################################################################
#
# aamp
#
################################################################################

AAMP_VERSION = 1bff88085d38812bf39cce37bf39809ddb8a6eb8
AAMP_SITE_METHOD = git
AAMP_SITE = https://github.com/rdkcmf/rdk-aamp
AAMP_INSTALL_STAGING = YES

AAMP_DEPENDENCIES = libcurl libdash libxml2 cjson aampabr

$(eval $(cmake-package))
