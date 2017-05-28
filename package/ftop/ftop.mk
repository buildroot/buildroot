################################################################################
#
# ftop
#
################################################################################

FTOP_VERSION = 1.0
FTOP_SOURCE = ftop-$(FTOP_VERSION).tar.bz2
FTOP_SITE = https://sourceforge.net/projects/ftop/files/ftop/$(FTOP_VERSION)
FTOP_DEPENDENCIES = ncurses
FTOP_LICENSE = GPLv3+
FTOP_LICENSE_FILES = COPYING

$(eval $(autotools-package))
