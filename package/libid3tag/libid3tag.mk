################################################################################
#
# libid3tag
#
################################################################################

LIBID3TAG_VERSION = 0.16.3
LIBID3TAG_SOURCE = $(LIBID3TAG_VERSION).tar.gz
LIBID3TAG_SITE = https://codeberg.org/tenacityteam/libid3tag/archive
LIBID3TAG_LICENSE = GPL-2.0+
LIBID3TAG_LICENSE_FILES = COPYING COPYRIGHT
LIBID3TAG_INSTALL_STAGING = YES
LIBID3TAG_DEPENDENCIES = zlib

$(eval $(cmake-package))
