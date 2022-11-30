################################################################################
#
# tinycompress
#
################################################################################

TINYCOMPRESS_VERSION = 1.2.8
TINYCOMPRESS_SOURCE = tinycompress-$(TINYCOMPRESS_VERSION).tar.bz2
TINYCOMPRESS_SITE = https://www.alsa-project.org/files/pub/tinycompress
TINYCOMPRESS_LICENSE = BSD-3-Clause and LGPL-2.1
TINYCOMPRESS_LICENSE_FILES = COPYING

$(eval $(autotools-package))
