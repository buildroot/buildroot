################################################################################
#
# kodi-vfs-sftp
#
################################################################################

KODI_VFS_SFTP_VERSION = 9fe870e71a10a37f2d793b2261bac48b195f2705
KODI_VFS_SFTP_SITE = $(call github,xbmc,vfs.sftp,$(KODI_VFS_SFTP_VERSION))
KODI_VFS_SFTP_LICENSE = GPL-2.0+
KODI_VFS_SFTP_LICENSE_FILES = LICENSE.md
KODI_VFS_SFTP_DEPENDENCIES = kodi libssh openssl zlib

$(eval $(cmake-package))
