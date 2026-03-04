################################################################################
#
# iniparser
#
################################################################################

INIPARSER_VERSION = 4.2.6
INIPARSER_SITE = https://gitlab.com/iniparser/iniparser/-/archive/v$(INIPARSER_VERSION)
INIPARSER_SOURCE = iniparser-v$(INIPARSER_VERSION).tar.gz
INIPARSER_INSTALL_STAGING = YES
INIPARSER_LICENSE = MIT
INIPARSER_LICENSE_FILES = LICENSE

$(eval $(cmake-package))
