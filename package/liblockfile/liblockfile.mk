################################################################################
#
# liblockfile
#
################################################################################

LIBLOCKFILE_VERSION = 1.17
LIBLOCKFILE_SOURCE = liblockfile_$(LIBLOCKFILE_VERSION).orig.tar.gz
LIBLOCKFILE_SITE = http://snapshot.debian.org/archive/debian/20210128T210947Z/pool/main/libl/liblockfile
LIBLOCKFILE_PATCH = liblockfile_$(LIBLOCKFILE_VERSION)-1.debian.tar.bz2

LIBLOCKFILE_LICENSE = LGPL-2.0+, GPL-2.0+ (dotlockfile)
LIBLOCKFILE_LICENSE_FILES = COPYRIGHT licenses/GPL-2 licenses/LGPL-2

# We're patching Makefile.in
LIBLOCKFILE_AUTORECONF = YES
LIBLOCKFILE_INSTALL_STAGING = YES
LIBLOCKFILE_CONF_OPTS = --mandir=/usr/share/man

$(eval $(autotools-package))
