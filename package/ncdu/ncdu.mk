################################################################################
#
# ncdu
#
################################################################################

NCDU_VERSION = 1.22
NCDU_SITE = https://dev.yorhel.nl/download

NCDU_DEPENDENCIES = host-pkgconf ncurses

NCDU_LICENSE = MIT
NCDU_LICENSE_FILES = COPYING

$(eval $(autotools-package))
