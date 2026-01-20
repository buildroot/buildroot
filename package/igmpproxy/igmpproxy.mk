################################################################################
#
# igmpproxy
#
################################################################################

IGMPPROXY_VERSION = 0.4
IGMPPROXY_SITE = \
	https://github.com/pali/igmpproxy/releases/download/$(IGMPPROXY_VERSION)
IGMPPROXY_AUTORECONF = YES
IGMPPROXY_LICENSE = GPL-2.0+, BSD-3-Clause (mrouted)
IGMPPROXY_LICENSE_FILES = COPYING GPL.txt Stanford.txt

IGMPPROXY_CPE_ID_VENDOR = pali

$(eval $(autotools-package))
