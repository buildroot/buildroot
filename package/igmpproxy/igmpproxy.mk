################################################################################
#
# igmpproxy
#
################################################################################

IGMPPROXY_VERSION = 0.3
IGMPPROXY_SITE = \
	https://github.com/pali/igmpproxy/releases/download/$(IGMPPROXY_VERSION)
IGMPPROXY_AUTORECONF = YES
IGMPPROXY_LICENSE = GPL-2.0+, BSD-3-Clause (mrouted)
IGMPPROXY_LICENSE_FILES = COPYING GPL.txt Stanford.txt

$(eval $(autotools-package))
