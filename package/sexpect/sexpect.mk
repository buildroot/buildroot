################################################################################
#
# sexpect
#
################################################################################

SEXPECT_VERSION = 2.3.15
SEXPECT_SITE = $(call github,clarkwang,sexpect,v$(SEXPECT_VERSION))
SEXPECT_LICENSE = GPL-3.0
SEXPECT_LICENSE_FILES = LICENSE
SEXPECT_SUPPORTS_IN_SOURCE_BUILD = NO

$(eval $(cmake-package))
