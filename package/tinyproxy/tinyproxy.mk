################################################################################
#
# tinyproxy
#
################################################################################

TINYPROXY_VERSION = 1.11.2
TINYPROXY_SITE = https://github.com/tinyproxy/tinyproxy/releases/download/$(TINYPROXY_VERSION)
TINYPROXY_SOURCE = tinyproxy-$(TINYPROXY_VERSION).tar.xz
TINYPROXY_LICENSE = GPL-2.0+
TINYPROXY_LICENSE_FILES = COPYING
TINYPROXY_CPE_ID_VALID = YES

$(eval $(autotools-package))
