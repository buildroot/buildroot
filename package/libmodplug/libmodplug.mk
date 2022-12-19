################################################################################
#
# libmodplug
#
################################################################################

LIBMODPLUG_VERSION = d1b97ed
LIBMODPLUG_SITE = $(call github,Konstanty,libmodplug,$(LIBMODPLUG_VERSION))
LIBMODPLUG_INSTALL_STAGING = YES
LIBMODPLUG_LICENSE = Public Domain
LIBMODPLUG_LICENSE_FILES = COPYING
LIBMODPLUG_CPE_ID_VENDOR = konstanty_bialkowski
# Our version is actually newer than this, but having this allows to
# not have reports about CVEs for versions older than 0.8.9.0.
LIBMODPLUG_CPE_ID_VERSION = 0.8.9.0

$(eval $(cmake-package))
