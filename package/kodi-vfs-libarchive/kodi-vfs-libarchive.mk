################################################################################
#
# kodi-vfs-libarchive
#
################################################################################

KODI_VFS_LIBARCHIVE_VERSION = 21.0.2-Omega
KODI_VFS_LIBARCHIVE_SITE = $(call github,xbmc,vfs.libarchive,$(KODI_VFS_LIBARCHIVE_VERSION))
KODI_VFS_LIBARCHIVE_LICENSE = GPL-2.0+
KODI_VFS_LIBARCHIVE_LICENSE_FILES = LICENSE.md
KODI_VFS_LIBARCHIVE_DEPENDENCIES = \
	bzip2 \
	kodi \
	libarchive \
	lz4 \
	lzo \
	openssl \
	xz \
	zlib

$(eval $(cmake-package))
