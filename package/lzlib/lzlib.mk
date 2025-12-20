################################################################################
#
# lzlib
#
################################################################################

LZLIB_VERSION = 0.4.1.53-4
LZLIB_SUBDIR = lzlib
LZLIB_LICENSE = MIT
LZLIB_LICENSE_FILES = $(LZLIB_SUBDIR)/lzlib.c
LZLIB_DEPENDENCIES = zlib

$(eval $(luarocks-package))
