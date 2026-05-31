################################################################################
#
# minizip-zlib
#
################################################################################

# When updating the version here, please also update the libzlib package
MINIZIP_ZLIB_VERSION = 1.3.2
MINIZIP_ZLIB_SOURCE = zlib-$(MINIZIP_ZLIB_VERSION).tar.xz
MINIZIP_ZLIB_SITE = https://www.zlib.net
MINIZIP_ZLIB_DL_SUBDIR = libzlib
MINIZIP_ZLIB_LICENSE = Zlib
MINIZIP_ZLIB_LICENSE_FILES = LICENSE
MINIZIP_ZLIB_INSTALL_STAGING = YES
MINIZIP_ZLIB_SUBDIR = contrib/minizip
# configure is not shipped in contrib/minizip
MINIZIP_ZLIB_AUTORECONF = YES
MINIZIP_ZLIB_DEPENDENCIES = zlib
# demos must be disabled to avoid a conflict with BR2_PACKAGE_MINIZIP_DEMOS
MINIZIP_ZLIB_CONF_OPTS = --disable-demos

$(eval $(autotools-package))
