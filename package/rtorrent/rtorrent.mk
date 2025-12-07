################################################################################
#
# rtorrent
#
################################################################################

# When updating the version, please also update libtorrent
RTORRENT_VERSION = 0.15.3
RTORRENT_SITE = https://github.com/rakshasa/rtorrent/releases/download/v$(RTORRENT_VERSION)
RTORRENT_DEPENDENCIES = host-pkgconf libcurl libtorrent ncurses
RTORRENT_LICENSE = GPL-2.0
RTORRENT_LICENSE_FILES = COPYING
RTORRENT_CONF_OPTS = --disable-execinfo

$(eval $(autotools-package))
