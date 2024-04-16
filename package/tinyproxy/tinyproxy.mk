################################################################################
#
# tinyproxy
#
################################################################################

TINYPROXY_VERSION = 1.11.1
TINYPROXY_SITE = https://github.com/tinyproxy/tinyproxy/releases/download/$(TINYPROXY_VERSION)
TINYPROXY_SOURCE = tinyproxy-$(TINYPROXY_VERSION).tar.xz
TINYPROXY_LICENSE = GPL-2.0+
TINYPROXY_LICENSE_FILES = COPYING
TINYPROXY_CPE_ID_VALID = YES

# 0001-prevent-junk-from-showing-up-in-error-page-in-invalid-requests.patch
TINYPROXY_IGNORE_CVES += CVE-2022-40468

$(eval $(autotools-package))
