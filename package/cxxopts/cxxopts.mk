################################################################################
#
# cxxopts
#
################################################################################

CXXOPTS_VERSION = 3.3.1
CXXOPTS_SITE = $(call github,jarro2783,cxxopts,v$(CXXOPTS_VERSION))
CXXOPTS_LICENSE = MIT
CXXOPTS_LICENSE_FILES = LICENSE

CXXOPTS_INSTALL_STAGING = YES
CXXOPTS_INSTALL_TARGET = NO

$(eval $(cmake-package))
