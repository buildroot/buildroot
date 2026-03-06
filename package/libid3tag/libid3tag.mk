################################################################################
#
# libid3tag
#
################################################################################

LIBID3TAG_VERSION = 0.16.4
LIBID3TAG_SOURCE = id3tag-$(LIBID3TAG_VERSION)-source.tar.gz
LIBID3TAG_SITE = https://codeberg.org/tenacityteam/libid3tag/releases/download/$(LIBID3TAG_VERSION)
LIBID3TAG_LICENSE = GPL-2.0+
LIBID3TAG_LICENSE_FILES = COPYING COPYRIGHT
LIBID3TAG_INSTALL_STAGING = YES
LIBID3TAG_DEPENDENCIES = host-gperf zlib

$(eval $(cmake-package))
