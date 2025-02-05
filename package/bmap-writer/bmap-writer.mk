################################################################################
#
# bmap-writer
#
################################################################################

BMAP_WRITER_VERSION = 1.0.2
BMAP_WRITER_SITE = $(call github,embetrix,bmap-writer,$(BMAP_WRITER_VERSION))
BMAP_WRITER_LICENSE = GPL-3.0
BMAP_WRITER_LICENSE_FILES = LICENSE
BMAP_WRITER_DEPENDENCIES = host-pkgconf libarchive tinyxml2
HOST_BMAP_WRITER_DEPENDENCIES = host-pkgconf host-libarchive host-tinyxml2

$(eval $(cmake-package))
$(eval $(host-cmake-package))
