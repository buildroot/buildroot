################################################################################
#
# websocketpp
#
################################################################################

WEBSOCKETPP_VERSION = 0.8.2
WEBSOCKETPP_SITE = $(call github,zaphoyd,websocketpp,$(WEBSOCKETPP_VERSION))
WEBSOCKETPP_LICENSE = BSD-3-Clause, MIT, Zlib
WEBSOCKETPP_LICENSE_FILES = COPYING
WEBSOCKETPP_CPE_ID_VENDOR = zaphoyd
WEBSOCKETPP_INSTALL_STAGING = YES
# Only installs headers
WEBSOCKETPP_INSTALL_TARGET = NO

$(eval $(cmake-package))
