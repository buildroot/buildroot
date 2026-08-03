################################################################################
#
# hare-xml
#
################################################################################

HARE_XML_VERSION = 0.25.2.0
HARE_XML_SITE_METHOD = git
HARE_XML_SITE = https://git.sr.ht/~sircmpwn/hare-xml
HARE_XML_LICENSE = MPL-2.0
HARE_XML_LICENSE_FILES = COPYING
HARE_XML_INSTALL_STAGING = YES

$(eval $(hare-package))
