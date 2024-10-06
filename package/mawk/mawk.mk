################################################################################
#
# mawk
#
################################################################################

MAWK_VERSION = 1.3.4-20240905
MAWK_SITE = https://invisible-mirror.net/archives/mawk
MAWK_SOURCE = mawk-$(MAWK_VERSION).tgz
MAWK_LICENSE = GPL-2.0
MAWK_LICENSE_FILES = COPYING

$(eval $(autotools-package))
