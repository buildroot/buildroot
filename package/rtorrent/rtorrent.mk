################################################################################
#
# rtorrent
#
################################################################################

RTORRENT_VERSION = 0.9.8
RTORRENT_SITE = http://rtorrent.net/downloads
RTORRENT_DEPENDENCIES = host-pkgconf libcurl libtorrent ncurses
RTORRENT_LICENSE = GPL-2.0
RTORRENT_LICENSE_FILES = COPYING
# We're patching configure.ac
RTORRENT_AUTORECONF = YES
RTORRENT_CONF_OPTS = --disable-execinfo

$(eval $(autotools-package))
