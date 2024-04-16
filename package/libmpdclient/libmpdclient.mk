################################################################################
#
# libmpdclient
#
################################################################################

LIBMPDCLIENT_VERSION_MAJOR = 2
LIBMPDCLIENT_VERSION = $(LIBMPDCLIENT_VERSION_MAJOR).22
LIBMPDCLIENT_SOURCE = libmpdclient-$(LIBMPDCLIENT_VERSION).tar.xz
LIBMPDCLIENT_SITE = http://www.musicpd.org/download/libmpdclient/$(LIBMPDCLIENT_VERSION_MAJOR)
LIBMPDCLIENT_INSTALL_STAGING = YES
LIBMPDCLIENT_LICENSE = BSD-2-Clause, BSD-3-Clause
LIBMPDCLIENT_LICENSE_FILES = \
	LICENSES/BSD-2-Clause.txt LICENSES/BSD-3-Clause.txt

$(eval $(meson-package))
